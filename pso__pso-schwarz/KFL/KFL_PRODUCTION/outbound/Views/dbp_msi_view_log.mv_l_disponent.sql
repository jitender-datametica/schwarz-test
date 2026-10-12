CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_disponent (mandant_id, disponent_id) AS SELECT mandant_id,
 disponent_id
FROM kfl_production_dbp_view.v_l_disponent;