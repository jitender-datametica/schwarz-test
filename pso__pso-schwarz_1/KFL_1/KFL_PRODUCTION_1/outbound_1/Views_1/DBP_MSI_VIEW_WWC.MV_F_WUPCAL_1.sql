CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_f_wupcal_1 (wup_id, mandant_id, nb_id, dat, offen, werbewoche,
bonanzahl, bonanzahl_imbiss, datenlieferung, bonanzahl_misvier, datenlieferung_artbew, datenlieferung_bonanzahl,
datenlieferung_misvier, datenlieferung_qbm_status, bonanzahl_sug) AS SELECT wup_id,
 mandant_id,
 nb_id,
 dat,
 offen,
 werbewoche,
 bonanzahl,
 bonanzahl_imbiss,
  CASE
  WHEN datenlieferung_artbew_wg_sum IN (2, 3)
  THEN 0
  ELSE datenlieferung_artbew_wg_sum
  END AS datenlieferung,
 bonanzahl_misvier,
 datenlieferung_artbew,
 datenlieferung_bonanzahl,
 datenlieferung_misvier,
 datenlieferung_qbm_status,
 bonanzahl_sug
FROM kfl_production_dbp_view.v_wupcal_1 AS V01;