-- 20.06.2023 snik: SPEC0200569 Lookup AAD_SCENARIO_2
 CREATE OR REPLACE VIEW dbp_msi_view_aad.mv_aad_scenario_2 (scenario_id
, scenario_grp_id) AS SELECT scenario_id,
 scenario_grp_id
FROM kfl_production_dbp_view.v_aad_scenario_2 AS v01;