CREATE OR REPLACE VIEW DBP_VIEW.V_AAD_SCENARIO_METRIC_SPR_ZU AS 
    SELECT 
		scenario_id,
        scenario_metric_id,
        spr_id,
        mandant_id,
        scenario_metric_descr

FROM DBP_DATA.AAD_SCENARIO_METRIC_SPR_ZU ;