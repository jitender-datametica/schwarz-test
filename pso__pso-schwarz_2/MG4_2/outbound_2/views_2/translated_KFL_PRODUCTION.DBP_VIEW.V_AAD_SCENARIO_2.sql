CREATE OR REPLACE VIEW kfl_production_dbp_view.v_aad_scenario_2 (scenario_id, scenario_grp_id, dwh_created_tmsp,
dwh_updated_tmsp) AS SELECT scenario_id,
 scenario_grp_id,
 dwh_created_tmsp,
 dwh_updated_tmsp
FROM kfl_production_dbp_data.aad_scenario_2;