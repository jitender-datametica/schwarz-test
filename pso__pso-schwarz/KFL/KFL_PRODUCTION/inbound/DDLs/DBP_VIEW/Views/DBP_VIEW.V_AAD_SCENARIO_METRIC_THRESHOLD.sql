CREATE OR REPLACE VIEW DBP_VIEW.V_AAD_SCENARIO_METRIC_THRESHOLD AS 
    SELECT 
        scenario_id,
        scenario_metric_id,
        mandant_id,
        region_id,
        scenario_metric_threshold_min_val,
        scenario_metric_threshold_max_val,
        scenario_metric_threshold_init_val,
        scenario_metric_unit_id

FROM DBP_DATA.AAD_SCENARIO_METRIC_THRESHOLD;