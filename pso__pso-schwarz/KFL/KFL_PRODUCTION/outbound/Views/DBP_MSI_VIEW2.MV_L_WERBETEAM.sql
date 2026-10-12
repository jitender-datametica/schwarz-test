CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_werbeteam (mandant_id, werbeteam_cd, werbebereich_cd,
werbeteam_bez) AS SELECT mandant_id,
 werbeteam_cd,
 werbebereich_cd,
 werbeteam_bez
FROM kfl_production_dbp_view.v_l_werbeteam AS V01
WHERE mandant_id = 1;