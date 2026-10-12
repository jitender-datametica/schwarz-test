CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_l_werbeteam_1 (mandant_id, werbeteam_cd, werbebereich_cd,
werbeteam_bez) AS SELECT mandant_id,
 werbeteam_cd,
 werbebereich_cd,
 werbeteam_bez
FROM kfl_production_dbp_view.v_l_werbeteam_1 AS V01;