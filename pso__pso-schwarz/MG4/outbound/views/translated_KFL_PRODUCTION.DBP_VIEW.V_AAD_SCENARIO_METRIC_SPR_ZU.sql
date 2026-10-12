CREATE OR REPLACE VIEW kfl_production_dbp_view.v_aad_scenario_metric_spr_zu (scenario_id, scenario_metric_id, spr_id,
mandant_id, scenario_metric_descr) AS SELECT scenario_id,
 scenario_metric_id,
 spr_id,
 mandant_id,
 scenario_metric_descr
FROM kfl_production_dbp_data.aad_scenario_metric_spr_zu;