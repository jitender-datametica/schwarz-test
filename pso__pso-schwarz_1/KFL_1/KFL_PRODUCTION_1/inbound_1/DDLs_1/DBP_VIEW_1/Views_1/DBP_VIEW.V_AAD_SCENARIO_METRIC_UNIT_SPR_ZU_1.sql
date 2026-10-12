CREATE OR REPLACE VIEW DBP_VIEW.V_AAD_SCENARIO_METRIC_UNIT_SPR_ZU_1 AS 
    SELECT 
        scenario_metric_unit_id,
        spr_id,
        mandant_id,
        scenario_metric_unit_descr

FROM DBP_DATA.AAD_SCENARIO_METRIC_UNIT_SPR_ZU_1 ;