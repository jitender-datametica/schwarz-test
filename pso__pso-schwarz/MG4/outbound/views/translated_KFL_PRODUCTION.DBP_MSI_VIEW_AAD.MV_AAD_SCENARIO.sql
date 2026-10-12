-- 20.06.2023 snik: SPEC0200569 Lookup AAD_SCENARIO
 CREATE OR REPLACE VIEW dbp_msi_view_aad.mv_aad_scenario (scenario_id
, scenario_grp_id) AS SELECT scenario_id,
 scenario_grp_id
FROM kfl_production_dbp_view.v_aad_scenario AS v01;