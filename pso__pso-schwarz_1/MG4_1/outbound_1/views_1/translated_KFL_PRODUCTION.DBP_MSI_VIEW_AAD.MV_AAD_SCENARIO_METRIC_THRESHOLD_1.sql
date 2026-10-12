-- 30.06.2023 staeblern initale Erstellung

-- Notwendig, da AAD_SCENARIO_METRIC_THRESHOLD_1 standardmaessig nur auf Landesebene vorhanden ist

-- Alle Region_1 erhalten als Default den Landeswert

-- Region_1 kommen erst in die AAD_SCENARIO_METRIC_THRESHOLD_1 wenn diese ueber einen Antrag genehmigt wurden ist.

CREATE OR REPLACE VIEW dbp_msi_view_aad.mv_aad_scenario_metric_threshold_1 (scenario_id, mandant_id, region_id,
scenario_metric_id, scenario_metric_unit_id, scenario_metric_threshold_min_val, scenario_metric_threshold_max_val,
scenario_metric_threshold_init_val) AS SELECT scenario_id,
 mandant_id,
 region_id,
 scenario_metric_id,
 scenario_metric_unit_id,
 scenario_metric_threshold_min_val,
 scenario_metric_threshold_max_val,
 scenario_metric_threshold_init_val
FROM kfl_production_dbp_view.v_aad_scenario_metric_threshold_1
UNION ALL
SELECT th2.scenario_id,
 vs.mandant_id,
 vs.vs_id AS region_id,
 th2.scenario_metric_id,
 th2.scenario_metric_unit_id,
 th2.scenario_metric_threshold_min_val,
 th2.scenario_metric_threshold_max_val,
 th2.scenario_metric_threshold_init_val
FROM kfl_production_dbp_view.v_vs_1 AS vs_1
 INNER JOIN kfl_production_dbp_view.v_aad_scenario_metric_threshold_1 AS th2 ON vs.mandant_id = th2.mandant_id AND th2.region_id
    = 0
WHERE (vs.mandant_id, vs.vs_id, th2.scenario_id, th2.scenario_metric_id) NOT IN (SELECT (mandant_id, region_id,
     scenario_id, scenario_metric_id)
   FROM kfl_production_dbp_view.v_aad_scenario_metric_threshold_1);