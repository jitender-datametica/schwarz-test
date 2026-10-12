create or replace view KFL_PRODUCTION.DBP_VIEW.V_AAD_SCENARIO_GRP_SPR_ZU_1(
	SCENARIO_GRP_ID,
	SPR_ID,
	MANDANT_ID,
	SCENARIO_GRP_DESCR
) as 
    SELECT 
        scenario_grp_id,
        spr_id,
        mandant_id,
        scenario_grp_descr

FROM DBP_DATA.AAD_SCENARIO_GRP_SPR_ZU_1 ;