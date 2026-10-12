CREATE OR REPLACE VIEW kfl_production_dbp_view.v_aad_scenario AS SELECT scenario_id,
 scenario_grp_id,
 dwh_created_tmsp,
 dwh_updated_tmsp
FROM kfl_production_dbp_data.aad_scenario;