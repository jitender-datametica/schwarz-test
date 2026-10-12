CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_user_wrg_typ_1 (mandant_id, user_id, wrg_typ_id,
currency_type) AS SELECT v02.mandant_id,
 v01.user_id,
 v01.wrg_typ_id,
  CASE
  WHEN v01.wrg_typ_id = 1
  THEN 'Local Currency'
  WHEN v01.wrg_typ_id = 0 AND v01.berichtskurs_typ_id = 0
  THEN 'EURO - akt. Berichtskurs'
  WHEN v01.wrg_typ_id = 0 AND v01.berichtskurs_typ_id = 1
  THEN 'EURO - Berichtskurs je GJ'
  ELSE NULL
  END AS currency_type
FROM kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS v01
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS v02 ON TRUE;