create or replace table dbp_etl.sort_kpi_tag_basis_2 (
  mandant_id number(38,0) not null,
  wup_id number(38,0) not null,
  dat date,
  kasse_nr number(38,0) not null,
  bon_nr number(38,0) not null,
  bon_id varchar(25) not null collate 'en-ci',
  kl_art_id number(38,0) not null,
  bon_umsatz_af number(18,2) not null,
  bon_umsatz_sa number(18,2) not null,
  bon_absatz_af number(18,3) not null,
  bon_absatz_sa number(18,3) not null,
  art_umsatz_af number(18,2) not null,
  art_umsatz_sa number(18,2) not null,
  art_absatz_af number(18,3) not null,
  art_absatz_sa number(18,3) not null,
  cpaf_fg number(38,0) not null,
  cpsa_fg number(38,0) not null
);

INSERT INTO dbp_etl.sort_kpi_tag_basis_2 (mandant_id
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
SELECT ok.mandant_id,
       ok.wup_id,
       ok.bon_dat AS dat,
       ok.kasse_nr,
       ok.bon_nr,
       ok.bon_id,
       ov.kl_art_id,
       0 AS bon_umsatz_af,
       0 AS bon_umsatz_sa,
       0 AS bon_absatz_af,
       0 AS bon_absatz_sa,
       SUM(CASE WHEN trim(ov.aktion_id) = '' THEN ov.umsatz_brutto ELSE 0 END) AS art_umsatz_af,
       SUM(CASE WHEN trim(ov.aktion_id) <> '' THEN ov.umsatz_brutto ELSE 0 END) AS art_umsatz_sa, 
       SUM(CASE WHEN trim(ov.aktion_id) = '' THEN ov.menge ELSE 0 END) AS art_absatz_af,
       SUM(CASE WHEN trim(ov.aktion_id) <> '' THEN ov.menge ELSE 0 END) AS art_absatz_sa,
       0 AS cpaf_fg,
       0 AS cpsa_fg
FROM dbp_spezial.v_ods_bon_kopf_union_2 ok
JOIN dbp_spezial.v_ods_bon_verkauf_union_2 ov
  ON ok.mandant_id = ov.mandant_id AND 
     ok.wup_id = ov.wup_id AND 
     ok.bon_id = ov.bon_id AND
     ok.bon_dat = ov.bon_dat
WHERE ok.bon_dat BETWEEN (SELECT MIN(dat) FROM dbp_data.tag_2 WHERE akt_wo = -5) AND (SELECT MAX(dat) FROM dbp_data.tag_2 WHERE akt_wo = -1) AND
      ok.turnover_fg = 1 AND 
      ov.wg_id <> 980 AND 
     (ok.bon_id, ok.bon_dat) NOT IN (SELECT bon_id,bon_dat FROM dbp_spezial.v_ods_bon_storno_union_2)
GROUP BY 1,2,3,4,5,6,7
;


UPDATE dbp_etl.sort_kpi_tag_basis_2 FROM (SELECT ok.mandant_id AS _mandant_id,
                                               ok.wup_id AS _wup_id,
                                               ok.bon_dat AS _dat,
                                               ok.kasse_nr AS _kasse_nr,
                                               ok.bon_nr AS _bon_nr,
                                               ok.bon_id AS _bon_id,
                                               SUM(CASE WHEN trim(ov.aktion_id) = '' THEN ov.umsatz_brutto ELSE 0 end) AS _bon_umsatz_af,
                                               SUM(CASE WHEN trim(ov.aktion_id) <> '' THEN ov.umsatz_brutto ELSE 0 end) AS _bon_umsatz_sa, 
                                               SUM(CASE WHEN trim(ov.aktion_id) = '' THEN ov.menge ELSE 0 end) AS _bon_absatz_af,
                                               SUM(CASE WHEN trim(ov.aktion_id) <> '' THEN ov.menge ELSE 0 end) AS _bon_absatz_sa
                                        FROM dbp_spezial.v_ods_bon_kopf_union_2 ok
                                        JOIN dbp_spezial.v_ods_bon_verkauf_union_2 ov
                                          ON ok.mandant_id = ov.mandant_id AND 
                                             ok.wup_id = ov.wup_id AND 
                                             ok.bon_id = ov.bon_id AND
                                             ok.bon_dat = ov.bon_dat
                                        WHERE ok.bon_dat BETWEEN (SELECT MIN(dat) FROM dbp_data.tag_2 WHERE akt_wo = -5) AND (SELECT MAX(dat) FROM dbp_data.tag_2 WHERE akt_wo = -1) AND
                                              ok.turnover_fg = 1 AND 
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

UPDATE dbp_etl.sort_kpi_tag_basis_2 SET cpaf_fg = 1
WHERE (((art_umsatz_af + art_umsatz_sa)/NULLIFZERO(art_absatz_af + art_absatz_sa) >= 8 AND 
       ((art_umsatz_af)/NULLIFZERO(bon_umsatz_af + bon_umsatz_sa)) > 0.85) OR 
       ((art_umsatz_af + art_umsatz_sa)/NULLIFZERO(art_absatz_af + art_absatz_sa) < 8 AND
       ((art_umsatz_af ) / NULLIFZERO(bon_umsatz_af + bon_umsatz_sa)) > 0.6))
;

UPDATE dbp_etl.sort_kpi_tag_basis_2 SET cpsa_fg = 1
WHERE (((art_umsatz_af + art_umsatz_sa)/NULLIFZERO(art_absatz_af + art_absatz_sa) >= 8 AND 
       ((art_umsatz_sa)/NULLIFZERO(bon_umsatz_af + bon_umsatz_sa)) > 0.85) OR 
       ((art_umsatz_af + art_umsatz_sa)/NULLIFZERO(art_absatz_af + art_absatz_sa) < 8 AND
       ((art_umsatz_sa ) / NULLIFZERO(bon_umsatz_af + bon_umsatz_sa)) > 0.6))
;

UPDATE dbp_etl.sort_kpi_tag_basis_2 SET cpsa_fg = 1
WHERE art_absatz_sa/NULLIFZERO(bon_absatz_af + bon_absatz_sa) >= 0.6
;

UPDATE dbp_etl.sort_kpi_tag_basis_2 SET cpaf_fg = 1
WHERE art_absatz_af/NULLIFZERO(bon_absatz_af + bon_absatz_sa) >= 0.6
;

DELETE FROM dbp_etl.sort_kpi_woche_basis_2
WHERE kjwo IN (SELECT b.kjwo FROM dbp_etl.sort_kpi_tag_basis_2 a JOIN dbp_data.tag_2 b ON a.dat = b.dat GROUP BY 1)
;

INSERT INTO dbp_etl.sort_kpi_woche_basis_2 (mandant_id
                                         ,wup_id
                                         ,kjwo
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
SELECT a.mandant_id,
       a.wup_id,
       b.kjwo,
       a.kl_art_id, 
       0 AS anz_bons,
       SUM(a.bon_umsatz_af) AS bon_ums_af,
       SUM(a.bon_umsatz_sa) AS bon_ums_sa,
       SUM(a.bon_absatz_af) AS bon_abs_af,
       SUM(a.bon_absatz_sa) AS bon_abs_sa,
       SUM(a.art_umsatz_af) AS art_ums_af,
       SUM(a.art_umsatz_sa) AS art_ums_sa,
       SUM(a.art_absatz_af) AS art_abs_af,
       SUM(a.art_absatz_sa) AS art_abs_sa,
       SUM(CASE WHEN a.art_umsatz_af > 0 THEN a.bon_umsatz_af + a.bon_umsatz_sa - a.art_umsatz_af ELSE 0 END) AS restbon_af,
       SUM(CASE WHEN a.art_umsatz_sa > 0 THEN a.bon_umsatz_af + a.bon_umsatz_sa - a.art_umsatz_sa ELSE 0 END) AS restbon_sa, 
       SUM(CASE WHEN a.art_umsatz_af > 0 THEN 1 ELSE 0 END) AS art_bons_af,
       SUM(CASE WHEN a.art_umsatz_sa > 0 THEN 1 ELSE 0 END) AS art_bons_sa,
       SUM(a.cpaf_fg) AS cp_bons_af,
       SUM(a.cpsa_fg) AS cp_bons_sa
FROM dbp_etl.sort_kpi_tag_basis_2 a
JOIN dbp_data.tag_2 b
  ON a.dat = b.dat
GROUP BY 1,2,3,4,5
;

UPDATE dbp_etl.sort_kpi_woche_basis_2 FROM (SELECT a.mandant_id,
                                                 a.wup_id,
	                                         b.kjwo,
                                                 COUNT(DISTINCT a.bon_id) AS anz_bons
                                          FROM dbp_etl.sort_kpi_tag_basis_2 a
                                          JOIN dbp_data.tag_2 b
                                            ON a.dat = b.dat
                                          GROUP BY 1,2,3) b

SET anz_bons = b.anz_bons

WHERE dbp_etl.sort_kpi_woche_basis.mandant_id = b.mandant_id AND
      dbp_etl.sort_kpi_woche_basis.wup_id = b.wup_id AND
      dbp_etl.sort_kpi_woche_basis.kjwo = b.kjwo
;

