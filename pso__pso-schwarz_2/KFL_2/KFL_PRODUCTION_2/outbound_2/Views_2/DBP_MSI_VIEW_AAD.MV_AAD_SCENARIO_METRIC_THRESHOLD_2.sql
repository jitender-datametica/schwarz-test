CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_aad_scenario_metric_threshold_2 AS SELECT scenario_id,
 mandant_id,
 region_id,
 scenario_metric_id,
 scenario_metric_unit_id,
 scenario_metric_threshold_min_val,
 scenario_metric_threshold_max_val,
 scenario_metric_threshold_init_val
FROM kfl_production_dbp_view.v_aad_scenario_metric_threshold_2
UNION ALL
SELECT TH2.scenario_id,
 VS.mandant_id,
 VS.vs_id AS region_id,
 TH2.scenario_metric_id,
 TH2.scenario_metric_unit_id,
 TH2.scenario_metric_threshold_min_val,
 TH2.scenario_metric_threshold_max_val,
 TH2.scenario_metric_threshold_init_val
FROM kfl_production_dbp_view.v_vs_2 AS VS_2
 INNER JOIN kfl_production_dbp_view.v_aad_scenario_metric_threshold_2 AS TH2 ON VS.mandant_id = TH2.mandant_id AND TH2.region_id
    = 0
WHERE (VS.mandant_id, VS.vs_id, TH2.scenario_id, TH2.scenario_metric_id) NOT IN (SELECT (mandant_id, region_id,
     scenario_id, scenario_metric_id)
   FROM kfl_production_dbp_view.v_aad_scenario_metric_threshold_2);