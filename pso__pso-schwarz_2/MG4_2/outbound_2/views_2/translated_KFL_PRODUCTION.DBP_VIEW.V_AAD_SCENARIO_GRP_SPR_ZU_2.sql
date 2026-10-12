CREATE OR REPLACE VIEW kfl_production_dbp_view.v_aad_scenario_grp_spr_zu_2 (scenario_grp_id, spr_id, mandant_id,
scenario_grp_descr) AS SELECT scenario_grp_id,
 spr_id,
 mandant_id,
 scenario_grp_descr
FROM kfl_production_dbp_data.aad_scenario_grp_spr_zu_2;