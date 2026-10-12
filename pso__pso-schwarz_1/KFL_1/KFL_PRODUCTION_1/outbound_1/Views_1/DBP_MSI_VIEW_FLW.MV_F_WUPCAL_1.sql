CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_wupcal_1 (wup_id, mandant_id, nb_id, dat, offen, werbewoche,
bonanzahl, datenlieferung, bonanzahl_misvier, datenlieferung_artbew, datenlieferung_bonanzahl, datenlieferung_misvier,
datenlieferung_qbm_status) AS SELECT wup_id,
 mandant_id,
 nb_id,
 dat,
 offen,
 werbewoche,
 bonanzahl_sug AS bonanzahl,
  CASE
  WHEN datenlieferung_artbew_wg_sum IN (2, 3)
  THEN 0
  ELSE datenlieferung_artbew_wg_sum
  END AS datenlieferung,
 bonanzahl_misvier,
 datenlieferung_artbew,
 datenlieferung_bonanzahl,
 datenlieferung_misvier,
 datenlieferung_qbm_status
FROM kfl_production_dbp_view.v_wupcal_1 AS V01
WHERE mandant_id IN (1, 2)
 AND bonanzahl_sug > 0;