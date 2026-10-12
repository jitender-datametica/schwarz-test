CREATE OR REPLACE VIEW DBP_VIEW.V_AAD_SCENARIO_DEACTIVATION AS 
    SELECT 
        scenario_id,
        mandant_id,
        dwh_created_tmsp

FROM DBP_DATA.AAD_SCENARIO_DEACTIVATION ;