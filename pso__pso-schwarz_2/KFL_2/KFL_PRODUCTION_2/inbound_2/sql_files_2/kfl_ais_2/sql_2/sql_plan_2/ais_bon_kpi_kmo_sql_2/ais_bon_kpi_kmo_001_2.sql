CREATE OR REPLACE TABLE dbp_etl.st_bon_kpi_kmo_2 (
      mandant_id INTEGER,
      kjmo_sort INTEGER,
      kl_art_id INTEGER,
      rb_total DECIMAL(18,3),
      artikel_bons_af INTEGER,
      artikel_bons_sa INTEGER,
      krw_af DECIMAL(15,10),
      krw_sa DECIMAL(15,10),
      cpq_total DECIMAL(15,10),
      cherry_bons_af INTEGER,
      cherry_bons_sa INTEGER
);

CREATE OR REPLACE TABLE dbp_etl.bf_bons_sort_basis_tmp_2 (
      mandant_id INTEGER NOT NULL,
      wup_id INTEGER NOT NULL,
      dat DATE,
      kasse_nr INTEGER NOT NULL,
      bon_nr INTEGER NOT NULL,
      bon_id VARCHAR(25) COLLATE 'en-ci',
      kl_art_id INTEGER NOT NULL,
      bon_umsatz_af DECIMAL(18,2) NOT NULL,
      bon_umsatz_sa DECIMAL(18,2) NOT NULL,
      bon_absatz_af DECIMAL(18,3) NOT NULL,
      bon_absatz_sa DECIMAL(18,3) NOT NULL,
      art_umsatz_af DECIMAL(18,2) NOT NULL,
      art_umsatz_sa DECIMAL(18,2) NOT NULL,
      art_absatz_af DECIMAL(18,3) NOT NULL,
      art_absatz_sa DECIMAL(18,3) NOT NULL,
      cpaf_fg INTEGER NOT NULL,
      cpsa_fg INTEGER NOT NULL)
;

INSERT INTO dbp_etl.bf_bons_sort_basis_tmp_2 (mandant_id
                                           ,wup_id
                                           ,dat
                                           ,kasse_nr
                                           ,bon_nr
                                           ,bon_id
                                           ,kl_art_id
                                           ,bon_umsatz_af
                                           ,bon_umsatz_sa
                                           ,bon_absatz_af
                                           ,bon_absatz_sa
                                           ,art_umsatz_af
                                           ,art_umsatz_sa
                                           ,art_absatz_af
                                           ,art_absatz_sa
                                           ,cpaf_fg
                                           ,cpsa_fg)
SELECT DISTINCT
       ok.mandant_id,
       ok.wup_id,
       ok.bon_dat,
       ok.kasse_nr,
       ok.bon_nr,
       ok.bon_id,
       ov.kl_art_id,
       sum(CASE WHEN ov.aktion_id = '' THEN ov.umsatz_brutto ELSE 0 end) over(partition by ok.bon_id) as bon_umsatz_af,
       sum(CASE WHEN ov.aktion_id <> '' THEN ov.umsatz_brutto ELSE 0 end) over(partition by ok.bon_id) as bon_umsatz_sa,
       sum(CASE WHEN ov.aktion_id = '' THEN ov.menge ELSE 0 end) over(partition by ok.bon_id) as bon_absatz_af,
       sum(CASE WHEN ov.aktion_id <> '' THEN ov.menge ELSE 0 end) over(partition by ok.bon_id) as bon_absatz_sa,
       sum(CASE WHEN ov.aktion_id = '' THEN ov.umsatz_brutto ELSE 0 end) over(partition by ok.bon_id,ov.kl_art_id) as art_umsatz_af,
       sum(CASE WHEN ov.aktion_id <> '' THEN ov.umsatz_brutto ELSE 0 end) over(partition by ok.bon_id,ov.kl_art_id) as art_umsatz_sa,
       sum(CASE WHEN ov.aktion_id = '' THEN ov.menge ELSE 0 end) over(partition by ok.bon_id,ov.kl_art_id) as art_absatz_af,
       sum(CASE WHEN ov.aktion_id <> '' THEN ov.menge ELSE 0 end) over(partition by ok.bon_id,ov.kl_art_id) as art_absatz_sa,
       0 AS cpaf_fg,
       0 AS cpsa_fg
FROM dbp_ods.ods_bon_kopf_2 ok
JOIN dbp_ods.ods_bon_verkauf_2 ov
  ON ok.mandant_id = ov.mandant_id AND 
     ok.wup_id = ov.wup_id AND 
     ok.bon_id = ov.bon_id AND
     ok.bon_dat = ov.bon_dat
WHERE ok.bon_dat BETWEEN CURRENT_DATE-60 AND CURRENT_DATE-1 AND
      ov.bon_dat BETWEEN CURRENT_DATE-60 AND CURRENT_DATE-1 AND
      ok.mandant_id > 1 AND ov.mandant_id > 1 AND
      ok.turnover_fg = 1 AND 
      ov.wg_id NOT IN (SELECT wg_id FROM dbp_data.wg_filter_zu_2 WHERE wg_filter_id = 5) AND 
     (ok.bon_id, ok.bon_dat) NOT IN (SELECT bon_id,bon_dat FROM dbp_ods.ods_bon_storno_2)
;

--new logic of cherrypicker flag
UPDATE dbp_etl.bf_bons_sort_basis_tmp_2 SET cpsa_fg = 1
WHERE (((art_umsatz_sa)/NullIfZero(bon_umsatz_af + bon_umsatz_sa)) > 0.85)
;

UPDATE dbp_etl.bf_bons_sort_basis_tmp_2 SET cpsa_fg = 1
WHERE art_absatz_sa/NULLIFZERO(bon_absatz_af + bon_absatz_sa) > 0.6
;

DELETE FROM dbp_etl.bf_bons_sort_sum_2
WHERE (mandant_id,dat,wup_id,kl_art_id) IN (SELECT mandant_id,dat,wup_id,kl_art_id FROM dbp_etl.bf_bons_sort_basis_tmp_2)
;

INSERT INTO dbp_etl.bf_bons_sort_sum_2 (mandant_id
                                                    ,wup_id
                                                    ,dat
                                                    ,kl_art_id
                                                    ,anz_bons
                                                    ,bon_ums_af
                                                    ,bon_ums_sa
                                                    ,bon_abs_af
                                                    ,bon_abs_sa
                                                    ,art_ums_af
                                                    ,art_ums_sa
                                                    ,art_abs_af
                                                    ,art_abs_sa
                                                    ,restbon_af
                                                    ,restbon_sa
                                                    ,art_bons_af
                                                    ,art_bons_sa
                                                    ,cp_bons_af
                                                    ,cp_bons_sa)
SELECT mandant_id,
       wup_id,
       dat,
       kl_art_id, 
       0 AS anz_bons,
       SUM(bon_umsatz_af) AS bon_ums_af,
       SUM(bon_umsatz_sa) AS bon_ums_sa,
       SUM(bon_absatz_af) AS bon_abs_af,
       SUM(bon_absatz_sa) AS bon_abs_sa,
       SUM(art_umsatz_af) AS art_ums_af,
       SUM(art_umsatz_sa) AS art_ums_sa,
       SUM(art_absatz_af) AS art_abs_af,
       SUM(art_absatz_sa) AS art_abs_sa,
       SUM(CASE WHEN art_umsatz_af > 0 THEN bon_umsatz_af + bon_umsatz_sa - art_umsatz_af ELSE 0 END) AS restbon_af,
       SUM(CASE WHEN art_umsatz_sa > 0 THEN bon_umsatz_af + bon_umsatz_sa - art_umsatz_sa ELSE 0 END) AS restbon_sa, 
       SUM(CASE WHEN art_umsatz_af > 0 THEN 1 ELSE 0 END) AS art_bons_af,
       SUM(CASE WHEN art_umsatz_sa > 0 THEN 1 ELSE 0 END) AS art_bons_sa,
       SUM(cpaf_fg) AS cp_bons_af,
       SUM(cpsa_fg) AS cp_bons_sa
FROM dbp_etl.bf_bons_sort_basis_tmp_2
GROUP BY 1,2,3,4,5
;

UPDATE dbp_etl.bf_bons_sort_sum_2 FROM (SELECT mandant_id,
                                             wup_id,
	                                         dat,
                                             COUNT(DISTINCT bon_id) AS anz_bons
                                      FROM dbp_etl.bf_bons_sort_basis_tmp_2
                                      GROUP BY 1,2,3) b

SET anz_bons = b.anz_bons

WHERE dbp_etl.bf_bons_sort_sum.mandant_id = b.mandant_id AND
      dbp_etl.bf_bons_sort_sum.wup_id = b.wup_id AND
      dbp_etl.bf_bons_sort_sum.dat = b.dat
;

DELETE FROM dbp_etl.st_bon_kpi_kmo_2
WHERE mandant_id > 1
;

INSERT INTO dbp_etl.st_bon_kpi_kmo_2 (mandant_id
                                   ,kjmo_sort
                                   ,kl_art_id
                                   ,rb_total
                                   ,artikel_bons_af
                                   ,artikel_bons_sa
                                   ,krw_af
                                   ,krw_sa
                                   ,cpq_total
                                   ,cherry_bons_af
                                   ,cherry_bons_sa)
SELECT a.mandant_id,
       d.kjmo_sort,
       a.kl_art_id,
      (SUM(a.restbon_af) + SUM(a.restbon_sa)) / NULLIFZERO(  SUM(a.art_bons_af + a.art_bons_sa)) AS rb_total,
       SUM(a.art_bons_af) AS artikel_bons_af,
       SUM(a.art_bons_sa) AS artikel_bons_sa,
       SUM(CAST(a.art_bons_af AS FLOAT)) / NULLIFZERO (SUM(CAST(a.anz_bons AS FLOAT))) AS krw_af,
       SUM(CAST(a.art_bons_sa AS FLOAT)) / NULLIFZERO (SUM(CAST(a.anz_bons AS FLOAT))) AS krw_sa,
      (SUM(CAST(a.cp_bons_af AS FLOAT))  + SUM(CAST(a.cp_bons_sa AS FLOAT)) ) / NULLIFZERO(SUM(CAST(a.art_bons_af AS FLOAT)+ CAST(a.art_bons_sa AS FLOAT))) AS cpq_total,
       SUM(a.cp_bons_af) AS cherry_bons_af,
       SUM(a.cp_bons_sa) AS cherry_bons_sa
FROM dbp_etl.bf_bons_sort_sum_2 a
JOIN dbp_data.art_2 b
  ON a.mandant_id = b.mandant_id AND
     a.kl_art_id = b.kl_art_id AND
     b.dat_bis = '9999-12-31'
JOIN dbp_data.art_wg_zu_per_2 c
  ON a.mandant_id = c.mandant_id AND
     b.art_id = c.art_id AND
     c.arthiertyp_id = 2 AND
     c.dat_bis = '9999-12-31'
JOIN DBP_MSI_DATA.EK_SORT_SORTIMENT_MAT_ZEITRAUM_2 d
  ON a.dat BETWEEN d.DAT_VON AND d.DAT_BIS
WHERE c.wg_id IN (SELECT wg_id FROM dbp_data.wg_filter_zu_2 WHERE wg_filter_id = 47) AND
      a.mandant_id > 1 AND
      a.art_bons_af + a.art_bons_sa > 0 AND
      d.kjmo_sort IN (SELECT kjmo FROM dbp_data.monat_2 WHERE akt_mo = -1)
GROUP BY 1,2,3
;

DELETE FROM DBP_ETL.kpi_aggregat_kmo_2
WHERE (kjmo_sort) IN (SELECT kjmo FROM dbp_data.monat_2 WHERE akt_mo = -1)
;

INSERT INTO DBP_ETL.kpi_aggregat_kmo_2 (mandant_id
                                     ,kjmo_sort
                                     ,kl_art_id
                                     ,rb_total
                                     ,artikel_bons_af
                                     ,artikel_bons_sa
                                     ,krw_af
                                     ,krw_sa
                                     ,cpq_total
                                     ,cherry_bons_af
                                     ,cherry_bons_sa)
SELECT mandant_id
      ,kjmo_sort
      ,kl_art_id
      ,rb_total
      ,artikel_bons_af
      ,artikel_bons_sa
      ,krw_af
      ,krw_sa
      ,cpq_total
      ,cherry_bons_af
      ,cherry_bons_sa
FROM dbp_etl.st_bon_kpi_kmo_2
WHERE (kjmo_sort) IN (SELECT kjmo FROM dbp_data.monat_2 WHERE akt_mo = -1)
;


-----Bonreichweite

delete from dbp_etl_process.sort_bon_receipt_kmo_2 where mandant_id > 1 and bon_dat > (SELECT MIN(dat) FROM dbp_data.tag_2 WHERE akt_mo = -4) ;

insert into dbp_etl_process.sort_bon_receipt_kmo_2 
select distinct
        ok.mandant_id,
        ok.wup_id,
        ok.bon_dat,
        a.art_id,
        count(distinct ok.bon_id) over (partition by ok.mandant_id,ok.wup_id,ok.bon_dat) as total_receipt,
        sum(distinct CASE WHEN ov.aktion_id = '' and ov.umsatz_brutto > 0 THEN 1 else 0 end) over (partition by ok.mandant_id,ok.wup_id,ok.bon_dat,ov.kl_art_id) as anz_bons_af_fg,
        sum(distinct CASE WHEN ov.aktion_id <> '' and ov.umsatz_brutto > 0 THEN 1 else 0 end) over (partition by ok.mandant_id,ok.wup_id,ok.bon_dat,ov.kl_art_id) as anz_bons_sa_fg
FROM dbp_spezial.v_ods_bon_kopf_union_2 ok
JOIN dbp_spezial.v_ods_bon_verkauf_union_2 ov
ON      ok.mandant_id = ov.mandant_id AND 
        ok.wup_id = ov.wup_id AND 
        ok.bon_id = ov.bon_id
JOIN dbp_data.art_2 a
ON      ov.mandant_id = a.mandant_id and
        ov.kl_art_id = a.kl_art_id
WHERE   ok.bon_dat > (SELECT MIN(dat) FROM dbp_data.tag_2 WHERE akt_mo = -4) and
        ov.bon_dat > (SELECT MIN(dat) FROM dbp_data.tag_2 WHERE akt_mo = -4) and
        ok.mandant_id > 1 and ov.mandant_id > 1 and
        turnover_fg = 1 AND ov.wg_id <> 980 AND
        (ok.bon_id, ok.bon_dat) NOT IN (SELECT bon_id,bon_dat FROM dbp_spezial.v_ods_bon_storno_union_2)
;

delete from dbp_etl_process.sort_bon_receipt_kmo_2 where mandant_id > 1 and bon_dat < (SELECT MIN(dat) FROM dbp_data.tag_2 WHERE akt_mo = -19) ;

