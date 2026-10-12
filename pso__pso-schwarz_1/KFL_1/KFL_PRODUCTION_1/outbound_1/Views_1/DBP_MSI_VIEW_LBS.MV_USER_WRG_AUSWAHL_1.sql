CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_user_wrg_auswahl_1 (user_id, wrg_typ_id, wrg_typ_bez,
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
  WHEN berichtskurs_typ_id = 0
  THEN 'akt. Berichtskurs'
  WHEN berichtskurs_typ_id = 1
  THEN 'hist. Berichtskurs'
  ELSE NULL
  END AS berichtskurs_typ_bez
FROM kfl_production_dbp_msi_data.user_wrg_typ_zu_1;