CREATE OR REPLACE VOLATILE TABLE _xxx_woche_sort AS (
SELECT c.kjmo as kjmo_sort
FROM dbp_data.monat_2 a
JOIN (SELECT kjmo_sort
      from dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2
      where kjwo_bis IN (SELECT max(kjwo) FROM dbp_data.art_nielsen_fakten_kjwo_2 WHERE mandant_id = 1)) b
  ON a.kjmo = b.kjmo_sort
JOIN dbp_data.monat_2 c
  ON a.akt_mo = c.akt_mo
);

DELETE FROM dbp_etl.bf_bons_sort_basis_2
WHERE dat BETWEEN (SELECT MIN(dat) FROM dbp_data.tag_2 WHERE akt_mo = -4) AND (SELECT dat_bis FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 WHERE kjmo_sort in (SELECT kjmo_sort FROM _xxx_woche_sort))
;

CREATE OR REPLACE TABLE dbp_etl.bf_bons_sort_basis_tmp_de_2 LIKE dbp_etl.bf_bons_sort_basis_2;

INSERT INTO dbp_etl.bf_bons_sort_basis_tmp_de_2
SELECT ok.mandant_id,
       ok.wup_id,
       ok.bon_dat,
       ok.kasse_nr,
       ok.bon_nr,
       ok.bon_id,
       ov.kl_art_id,
       0,
       0,
       0,
       0,
       Sum(CASE WHEN ov.aktion_id = '' THEN ov.umsatz_brutto ELSE 0 END) AS _art_umsatz_af,
       Sum(CASE WHEN ov.aktion_id <> '' THEN ov.umsatz_brutto ELSE 0 END) AS _art_umsatz_sa, 
       Sum(CASE WHEN ov.aktion_id = '' THEN ov.menge ELSE 0 END) AS _art_absatz_af,
       Sum(CASE WHEN ov.aktion_id <> '' THEN ov.menge ELSE 0 END) AS _art_absatz_sa,
       0,
       0
FROM dbp_spezial.v_ods_bon_kopf_union_2 ok
JOIN dbp_spezial.v_ods_bon_verkauf_union_2 ov
  ON ok.mandant_id = ov.mandant_id AND 
     ok.wup_id = ov.wup_id AND 
     ok.bon_id = ov.bon_id
WHERE ok.bon_dat BETWEEN (SELECT MIN(dat) FROM dbp_data.tag_2 WHERE akt_mo = -4) AND (SELECT dat_bis FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 WHERE kjmo_sort in (SELECT kjmo_sort FROM _xxx_woche_sort)) AND
      ov.bon_dat BETWEEN (SELECT MIN(dat) FROM dbp_data.tag_2 WHERE akt_mo = -4) AND (SELECT dat_bis FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 WHERE kjmo_sort in (SELECT kjmo_sort FROM _xxx_woche_sort)) AND
      ok.mandant_id = 1 AND
      ov.mandant_id = 1 AND
      ok.turnover_fg = 1 AND 
      ov.talon_id = 0 AND 
      ov.wg_id <> 980 AND 
     (ok.bon_id, ok.bon_dat) NOT IN (SELECT bon_id,bon_dat FROM dbp_spezial.v_ods_bon_storno_union_2)
GROUP BY 1,2,3,4,5,6,7
;

INSERT INTO dbp_etl.bf_bons_sort_basis_tmp_de_2
SELECT ok.mandant_id,
       ok.wup_id,
       ok.bon_dat,
       ok.kasse_nr,
       ok.bon_nr,
       ok.bon_id,
       ov.kl_art_id,
       0,
       0,
       0,
       0,
       Sum(CASE WHEN ov.aktion_id = '' THEN ov.umsatz_brutto ELSE 0 END) AS _art_umsatz_af,
       Sum(CASE WHEN ov.aktion_id <> '' THEN ov.umsatz_brutto ELSE 0 END) AS _art_umsatz_sa, 
       Sum(CASE WHEN ov.aktion_id = '' THEN ov.menge ELSE 0 END) AS _art_absatz_af,
       Sum(CASE WHEN ov.aktion_id <> '' THEN ov.menge ELSE 0 END) AS _art_absatz_sa,
       0,
	   0
FROM dbp_spezial.v_ods_bon_kopf_union_2 ok
JOIN dbp_spezial.v_ods_bon_verkauf_union_2 ov
  ON ok.mandant_id = ov.mandant_id AND 
     ok.wup_id = ov.wup_id AND 
     ok.bon_id = ov.bon_id
WHERE ok.bon_dat BETWEEN (SELECT MIN(dat) FROM dbp_data.tag_2 WHERE akt_mo = -4) AND (SELECT dat_bis FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 WHERE kjmo_sort in (SELECT kjmo_sort FROM _xxx_woche_sort)) AND
      ov.bon_dat BETWEEN (SELECT MIN(dat) FROM dbp_data.tag_2 WHERE akt_mo = -4) AND (SELECT dat_bis FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 WHERE kjmo_sort in (SELECT kjmo_sort FROM _xxx_woche_sort)) AND
      ok.mandant_id = 1 AND
      ov.mandant_id = 1 AND
      ok.turnover_fg = 1 AND 
      ov.talon_id <> 0 AND 
     (ok.wup_id,ov.talon_id) NOT IN (SELECT k.wup_id,z.talon_id
                                     FROM dbp_spezial.v_ods_talon_union_2 k
                                     JOIN dbp_spezial.v_ods_talon_det_union_2 z
                                       ON k.talon_id = z.talon_id AND
                                          k.wup_id = z.wup_id) AND
     (ok.bon_id, ok.bon_dat) NOT IN (SELECT bon_id,bon_dat FROM dbp_spezial.v_ods_bon_storno_union_2)
GROUP BY 1,2,3,4,5,6,7
;

UPDATE dbp_etl.bf_bons_sort_basis_tmp_de_2 FROM (SELECT ok.mandant_id AS _mandant_id,
                                                      ok.wup_id AS _wup_id,
                                                      ok.bon_dat AS _dat,
                                                      ok.kasse_nr AS _kasse_nr,
                                                      ok.bon_nr AS _bon_nr,
                                                      ok.bon_id AS _bon_id,
                                                      Sum(CASE WHEN ov.aktion_id = '' THEN ov.umsatz_brutto ELSE 0 end) AS _bon_umsatz_af,
                                                      Sum(CASE WHEN ov.aktion_id <> '' THEN ov.umsatz_brutto ELSE 0 end) AS _bon_umsatz_sa, 
                                                      Sum(CASE WHEN ov.aktion_id = '' THEN ov.menge ELSE 0 end) AS _bon_absatz_af,
                                                      Sum(CASE WHEN ov.aktion_id <> '' THEN ov.menge ELSE 0 end) AS _bon_absatz_sa
                                               FROM dbp_spezial.v_ods_bon_kopf_union_2 ok
                                               JOIN dbp_spezial.v_ods_bon_verkauf_union_2 ov
                                                 ON ok.mandant_id = ov.mandant_id AND 
                                                    ok.wup_id = ov.wup_id AND 
                                                    ok.bon_id = ov.bon_id
                                               WHERE ok.bon_dat BETWEEN (SELECT MIN(dat) FROM dbp_data.tag_2 WHERE akt_mo = -4) AND (SELECT dat_bis FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 WHERE kjmo_sort in (SELECT kjmo_sort FROM _xxx_woche_sort)) AND
                                                     ov.bon_dat BETWEEN (SELECT MIN(dat) FROM dbp_data.tag_2 WHERE akt_mo = -4) AND (SELECT dat_bis FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 WHERE kjmo_sort in (SELECT kjmo_sort FROM _xxx_woche_sort)) AND
                                                     ok.mandant_id = 1 AND
   						     ov.mandant_id = 1 AND
		                                     ok.turnover_fg = 1 AND 
                                                     ov.talon_id = 0 AND 
                                                     ov.wg_id <> 980 AND 
                                                    (ok.bon_id, ok.bon_dat) NOT IN (SELECT bon_id,bon_dat FROM dbp_spezial.v_ods_bon_storno_union_2)
                                               GROUP BY 1,2,3,4,5,6) shop

SET bon_umsatz_af = bon_umsatz_af + _bon_umsatz_af,
    bon_umsatz_sa = bon_umsatz_sa + _bon_umsatz_sa,
    bon_absatz_af = bon_absatz_af + _bon_absatz_af,
    bon_absatz_sa = bon_absatz_sa + _bon_absatz_sa

WHERE mandant_id = _mandant_id AND 
      wup_id = _wup_id AND 
      dat = _dat AND 
      kasse_nr = _kasse_nr AND 
      bon_nr = _bon_nr AND 
      bon_id = _bon_id
;

UPDATE dbp_etl.bf_bons_sort_basis_tmp_de_2 FROM (SELECT ok.mandant_id AS _mandant_id,
                                                      ok.wup_id AS _wup_id,
                                                      ok.bon_dat AS _dat,
                                                      ok.kasse_nr AS _kasse_nr,
                                                      ok.bon_nr AS _bon_nr,
                                                      ok.bon_id AS _bon_id,                                                 
                                                      Sum(CASE WHEN ov.aktion_id = '' THEN ov.umsatz_brutto ELSE 0 end) AS _bon_umsatz_af,
                                                      Sum(CASE WHEN ov.aktion_id <> '' THEN ov.umsatz_brutto ELSE 0 end) AS _bon_umsatz_sa, 
                                                      Sum(CASE WHEN ov.aktion_id = '' THEN ov.menge ELSE 0 end) AS _bon_absatz_af,
                                                      Sum(CASE WHEN ov.aktion_id <> '' THEN ov.menge ELSE 0 end) AS _bon_absatz_sa
                                               FROM dbp_spezial.v_ods_bon_kopf_union_2 ok
                                               JOIN dbp_spezial.v_ods_bon_verkauf_union_2 ov
                                                 ON ok.mandant_id = ov.mandant_id AND 
                                                    ok.wup_id = ov.wup_id AND 
                                                    ok.bon_id = ov.bon_id
                                               WHERE ok.bon_dat BETWEEN (SELECT MIN(dat) FROM dbp_data.tag_2 WHERE akt_mo = -4) AND (SELECT dat_bis FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 WHERE kjmo_sort in (SELECT kjmo_sort FROM _xxx_woche_sort)) AND
                                                     ov.bon_dat BETWEEN (SELECT MIN(dat) FROM dbp_data.tag_2 WHERE akt_mo = -4) AND (SELECT dat_bis FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 WHERE kjmo_sort in (SELECT kjmo_sort FROM _xxx_woche_sort)) AND
                                                     ok.mandant_id = 1 AND
                                                     ov.mandant_id = 1 AND
                                                     ok.turnover_fg = 1 AND 
                                                     ov.talon_id <> 0 AND 
                                                    (ok.wup_id,ov.talon_id) NOT IN (SELECT k.wup_id,z.talon_id
                                                                                    FROM dbp_spezial.v_ods_talon_union_2 k
                                                                                    JOIN dbp_spezial.v_ods_talon_det_union_2 z
                                                                                      ON k.talon_id = z.talon_id AND
                                                                                         k.wup_id = z.wup_id) AND
                                                    (ok.bon_id, ok.bon_dat) NOT IN (SELECT bon_id,bon_dat FROM dbp_spezial.v_ods_bon_storno_union_2)
                                               GROUP BY 1,2,3,4,5,6) shop

SET bon_umsatz_af = bon_umsatz_af + _bon_umsatz_af,
    bon_umsatz_sa = bon_umsatz_sa + _bon_umsatz_sa,
    bon_absatz_af = bon_absatz_af + _bon_absatz_af,
    bon_absatz_sa = bon_absatz_sa + _bon_absatz_sa

WHERE mandant_id = _mandant_id AND 
      wup_id = _wup_id AND 
      dat = _dat AND 
      kasse_nr = _kasse_nr AND 
      bon_nr = _bon_nr AND 
      bon_id = _bon_id
;


--new logic of cherrypicker flag
UPDATE dbp_etl.bf_bons_sort_basis_tmp_de_2 SET cpsa_fg = 1
WHERE (((art_umsatz_sa)/NullIfZero(bon_umsatz_af + bon_umsatz_sa)) > 0.85) AND
       dat BETWEEN (SELECT MIN(dat) FROM dbp_data.tag_2 WHERE akt_mo = -4) 
	   AND (SELECT dat_bis FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 WHERE kjmo_sort in (SELECT kjmo_sort FROM _xxx_woche_sort))
;

UPDATE dbp_etl.bf_bons_sort_basis_tmp_de_2 SET cpsa_fg = 1
WHERE art_absatz_sa/NullIfZero(bon_absatz_af + bon_absatz_sa) > 0.6 AND
      dat BETWEEN (SELECT MIN(dat) FROM dbp_data.tag_2 WHERE akt_mo = -4) AND (SELECT dat_bis FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 WHERE kjmo_sort in (SELECT kjmo_sort FROM _xxx_woche_sort))
;

MERGE INTO dbp_etl.bf_bons_sort_basis_2 a
USING (SELECT * FROM dbp_etl.bf_bons_sort_basis_tmp_de_2) b
 
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.dat = b.dat AND
     a.kasse_nr = b.kasse_nr AND
     a.bon_nr = b.bon_nr AND
     a.bon_id = b.bon_id AND
     a.kl_art_id = b.kl_art_id
	 
WHEN NOT MATCHED THEN INSERT (mandant_id
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
                      VALUES (b.mandant_id
                             ,b.wup_id
                             ,b.dat
                             ,b.kasse_nr
                             ,b.bon_nr
                             ,b.bon_id
                             ,b.kl_art_id
                             ,b.bon_umsatz_af
                             ,b.bon_umsatz_sa
                             ,b.bon_absatz_af
                             ,b.bon_absatz_sa
                             ,b.art_umsatz_af
                             ,b.art_umsatz_sa
                             ,b.art_absatz_af
                             ,b.art_absatz_sa
                             ,b.cpaf_fg
                             ,b.cpsa_fg)
;


DELETE FROM dbp_etl.bf_bons_sort_sum_2
WHERE dat BETWEEN (SELECT MIN(dat) FROM dbp_data.tag_2 WHERE akt_mo = -4) AND (SELECT dat_bis FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 WHERE kjmo_sort in (SELECT kjmo_sort FROM _xxx_woche_sort)) AND
      mandant_id = 1
;

INSERT INTO dbp_etl.bf_bons_sort_sum_2
SELECT mandant_id,
       wup_id,
       dat,
       kl_art_id, 
       0 AS anz_bon,
       Sum(bon_umsatz_af),
       Sum(bon_umsatz_sa),
       Sum(bon_absatz_af),
       Sum(bon_absatz_sa),
       Sum(art_umsatz_af),
       Sum(art_umsatz_sa),
       Sum(art_absatz_af),
       Sum(art_absatz_sa),
       Sum(CASE WHEN art_umsatz_af > 0 THEN bon_umsatz_af + bon_umsatz_sa - art_umsatz_af ELSE 0 END) AS RB_AF,
       Sum(CASE WHEN art_umsatz_sa > 0 THEN bon_umsatz_af + bon_umsatz_sa - art_umsatz_sa ELSE 0 END) AS RB_SA, 
       Sum(CASE WHEN art_umsatz_af > 0 THEN 1 ELSE 0 END) AS AF_Bons,
       Sum(CASE WHEN art_umsatz_sa > 0 THEN 1 ELSE 0 END) AS SA_Bons,
       Sum(cpaf_fg),
       Sum(cpsa_fg)
FROM dbp_etl.bf_bons_sort_basis_2
WHERE dat BETWEEN (SELECT MIN(dat) FROM dbp_data.tag_2 WHERE akt_mo = -4) AND (SELECT dat_bis FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 WHERE kjmo_sort in (SELECT kjmo_sort FROM _xxx_woche_sort)) AND
      mandant_id = 1
GROUP BY 1,2,3,4,5
;

UPDATE dbp_etl.bf_bons_sort_sum_2 FROM (SELECT mandant_id,
                                             wup_id,
                                             dat,
                                             Count(DISTINCT bon_id) AS anz_bons
                                     FROM dbp_etl.bf_bons_sort_basis_2
                                     WHERE dat BETWEEN (SELECT MIN(dat) FROM dbp_data.tag_2 WHERE akt_mo = -4) AND (SELECT dat_bis FROM dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 WHERE kjmo_sort in (SELECT kjmo_sort FROM _xxx_woche_sort)) AND
                                           mandant_id = 1
                                     GROUP BY 1,2,3) b

SET anz_bons = b.anz_bons

WHERE dbp_etl.bf_bons_sort_sum.mandant_id = b.mandant_id AND
      dbp_etl.bf_bons_sort_sum.wup_id = b.wup_id AND
      dbp_etl.bf_bons_sort_sum.dat = b.dat
;

DELETE FROM dbp_etl.bf_bons_sort_export_2
;

INSERT INTO dbp_etl.bf_bons_sort_export_2
SELECT w.mandant_id,
       mw.kjmo_sort,
       mw.monate_anz,
      'alle' AS Bereich,
       agg.kl_art_id,
      (Sum(agg.restbon_af) + Sum(agg.restbon_sa)) / NullIfZero(  Sum(art_bons_af + art_bons_sa)) AS RB_Total,
       Sum(agg.restbon_af) / NullIfZero(Sum(art_bons_af + art_bons_sa)) AS RB_AF,
       Sum(agg.restbon_sa) / NullIfZero (Sum(art_bons_af + art_bons_sa)) AS RB_SA,
       Sum(agg.restbon_af) AS Restbon_Brutto_AF,
       Sum(agg.restbon_sa) AS Restbon_Brutto_SA,
       Sum(art_bons_af) AS Artikel_Bons_AF,
       Sum(art_bons_sa) AS Artikel_Bons_SA,
      (Sum(Cast(art_bons_af AS FLOAT)) + Sum(Cast(art_bons_sa AS FLOAT))) /  NullIfZero (Sum(Cast(agg.anz_bons AS FLOAT))) AS KRW_Total, 
       Sum(Cast(art_bons_af AS FLOAT)) / NullIfZero (Sum(Cast(agg.anz_bons AS FLOAT))) AS KRW_AF,
       Sum(Cast(art_bons_sa AS FLOAT)) / NullIfZero (Sum(Cast(agg.anz_bons AS FLOAT))) AS KRW_SA,
       Sum(agg.anz_bons) AS Bons,
      (Sum(Cast(cp_bons_af AS FLOAT))  + Sum(Cast(cp_bons_sa AS FLOAT)) ) / NullIfZero(Sum(Cast(art_bons_af AS FLOAT)+ Cast(art_bons_sa AS FLOAT))) AS CPQ_Total,
       Sum(Cast(cp_bons_af AS FLOAT))  / NullIfZero(Sum(Cast(art_bons_af AS FLOAT))) AS CPQ_AF,
       Sum(Cast(cp_bons_sa AS FLOAT)) / NullIfZero(Sum(Cast(art_bons_sa AS FLOAT))) AS CPQ_SA,
       Sum(cp_bons_af) AS Cherry_Bons_AF,
       Sum(cp_bons_sa) AS Cherry_bons_SA,
       Count(DISTINCT(agg.dat)) AS Tage,
       Count(DISTINCT(agg.wup_id)) AS Maerkte
FROM dbp_etl.bf_bons_sort_sum_2 agg, dbp_data.wup_2 w, dbp_data.art_2 a, 
     dbp_data.art_wg_zu_per_2 aw, dbp_process.bf_sort_wg_2 sw, dbp_msi_data.ek_sort_sortiment_mat_zeitraum_2 mw
WHERE mw.kjmo_sort in (select kjmo_sort from _xxx_woche_sort) AND 
      agg.mandant_id = 1 AND 
      agg.mandant_id = w.mandant_id AND 
      agg.dat BETWEEN mw.dat_von AND mw.dat_bis AND 
      agg.wup_id = w.wup_id AND 
      agg.mandant_id = a.mandant_id AND 
      agg.kl_art_id = a.kl_art_id AND 
      a.dat_bis = '9999-12-31' AND 
      a.mandant_id = aw.mandant_id AND 
      a.art_id = aw.art_id AND 
      aw.arthiertyp_id = 2 AND 
      aw.dat_bis = '9999-12-31' AND 
      aw.mandant_id = sw.mandant_id AND 
      aw.arthiertyp_id = sw.arthiertyp_id AND 
      aw.wg_id = sw.wg_id AND
      art_bons_af + art_bons_sa > 0
GROUP BY 1,2,3,4,5
;


----- Bonreichweite

delete from dbp_etl_process.sort_bon_receipt_de_2 where mandant_id = 1 and bon_dat > (SELECT MIN(dat) FROM dbp_data.tag_2 WHERE akt_mo = -4) ;

insert into dbp_etl_process.sort_bon_receipt_de_2 
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
        ok.mandant_id = 1 and ov.mandant_id = 1 and
        turnover_fg = 1 AND ov.wg_id <> 980 AND
        (ok.bon_id, ok.bon_dat) NOT IN (SELECT bon_id,bon_dat FROM dbp_spezial.v_ods_bon_storno_union_2)
;

delete from dbp_etl_process.sort_bon_receipt_de_2 where mandant_id = 1 and bon_dat < (SELECT MIN(dat) FROM dbp_data.tag_2 WHERE akt_mo = -19) ;

