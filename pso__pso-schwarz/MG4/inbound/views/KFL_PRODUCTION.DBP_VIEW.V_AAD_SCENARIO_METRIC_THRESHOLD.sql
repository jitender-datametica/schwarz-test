create or replace view KFL_PRODUCTION.DBP_VIEW.V_AAD_SCENARIO_METRIC_THRESHOLD(
	SCENARIO_ID,
	SCENARIO_METRIC_ID,
	MANDANT_ID,
	REGION_ID,
	SCENARIO_METRIC_THRESHOLD_MIN_VAL,
	SCENARIO_METRIC_THRESHOLD_MAX_VAL,
	SCENARIO_METRIC_THRESHOLD_INIT_VAL,
	SCENARIO_METRIC_UNIT_ID
) as 
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