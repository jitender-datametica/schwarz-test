CREATE OR REPLACE VIEW DBP_VIEW.V_AAD_SCENARIO_2 AS 
    SELECT 
        scenario_id
        ,scenario_grp_id
        ,dwh_created_tmsp
        ,dwh_updated_tmsp


FROM DBP_DATA.AAD_SCENARIO_2 ;