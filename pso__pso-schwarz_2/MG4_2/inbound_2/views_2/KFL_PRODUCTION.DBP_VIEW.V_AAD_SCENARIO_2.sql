create or replace view KFL_PRODUCTION.DBP_VIEW.V_AAD_SCENARIO_2(
	SCENARIO_ID,
	SCENARIO_GRP_ID,
	DWH_CREATED_TMSP,
	DWH_UPDATED_TMSP
) as 
    SELECT 
        scenario_id
        ,scenario_grp_id
        ,dwh_created_tmsp
        ,dwh_updated_tmsp


FROM DBP_DATA.AAD_SCENARIO_2 ;