CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_user_wrg_auswahl_1 (user_id, wrg_typ_id, wrg_typ_bez,
berichtskurs_typ_id, berichtskurs_typ_bez) AS SELECT user_id,
 wrg_typ_id,
  CASE
  WHEN wrg_typ_id = 0
  THEN 'EURO'
  WHEN wrg_typ_id = 1
  THEN 'Land_1'
  ELSE 'keine Auswahl'
  END AS wrg_typ_bez,
 berichtskurs_typ_id,
  CASE
  WHEN wrg_typ_id = 1
  THEN 'Local Currency'
  WHEN wrg_typ_id = 0 AND berichtskurs_typ_id = 0
  THEN 'EURO - akt. Berichtskurs'
  WHEN wrg_typ_id = 0 AND berichtskurs_typ_id = 1
  THEN 'EURO - Berichtskurs je GJ'
  ELSE NULL
  END AS berichtskurs_typ_bez
FROM kfl_production_dbp_msi_v_view.v_user_wrg_typ_zu_1 AS V01;