CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_wg_verkettung AS SELECT mandant_id,
 wg_verkett_id
FROM kfl_production_dbp_view.v_l_wg_verkettung AS V01;