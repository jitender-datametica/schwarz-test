CREATE OR REPLACE VIEW kfl_production_dbp_view.v_aad_scenario_spr_zu_1 (scenario_id, spr_id, mandant_id, scenario_descr)
AS SELECT scenario_id,
 spr_id,
 mandant_id,
 scenario_descr
FROM kfl_production_dbp_data.aad_scenario_spr_zu_1;