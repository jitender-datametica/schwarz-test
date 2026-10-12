CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_aad_scenario AS SELECT scenario_id,
 scenario_grp_id
FROM kfl_production_dbp_view.v_aad_scenario AS V01;