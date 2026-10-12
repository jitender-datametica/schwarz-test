create or replace view KFL_PRODUCTION.DBP_VIEW.V_AAD_SCENARIO_METRIC_UNIT_SPR_ZU(
	SCENARIO_METRIC_UNIT_ID,
	SPR_ID,
	MANDANT_ID,
	SCENARIO_METRIC_UNIT_DESCR
) as 
    SELECT 
        scenario_metric_unit_id,
        spr_id,
        mandant_id,
        scenario_metric_unit_descr

FROM DBP_DATA.AAD_SCENARIO_METRIC_UNIT_SPR_ZU ;