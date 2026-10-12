CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_ganzpalette_fg_1 AS SELECT mandant_id,
 art_id,
  CASE
  WHEN ausg_menge_einh_id = 'PAL'
  THEN 1
  ELSE 0
  END AS ganzpalette_fg
FROM kfl_production_dbp_view.v_art_vorschlagswert_per_1 AS V01
WHERE mandant_id <> 1
 AND dat_bis = PARSE_DATE('%F', '9999-12-31')
UNION ALL
SELECT mandant_id,
 art_id,
  CASE
  WHEN ausg_menge_einh_id = paletten_faktor_einh_id AND TRIM(ausg_menge_einh_id) <> ' '
  THEN 1
  ELSE 0
  END AS ganzpalette_fg
FROM kfl_production_dbp_view.v_art_vorschlagswert_per_1 AS V01
WHERE mandant_id = 1
 AND dat_bis = PARSE_DATE('%F', '9999-12-31');