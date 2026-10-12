CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_user_wrg_typ_2 (user_id, wrg_typ_id, berichtskurs_typ_id,
currency_type) AS SELECT user_id,
 wrg_typ_id,
 berichtskurs_typ_id,
  CASE
  WHEN wrg_typ_id = 1
  THEN 'Local Currency'
  WHEN wrg_typ_id = 0 AND berichtskurs_typ_id = 0
  THEN 'EURO - akt. Berichtskurs'
  WHEN wrg_typ_id = 0 AND berichtskurs_typ_id = 1
  THEN 'EURO - Berichtskurs je GJ'
  ELSE NULL
  END AS currency_type
FROM kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V01;