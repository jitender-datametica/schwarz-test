create or replace view KFL_PRODUCTION.DBP_VIEW.V_AAD_SCENARIO_SPR_ZU(
	SCENARIO_ID,
	SPR_ID,
	MANDANT_ID,
	SCENARIO_DESCR
) as 
    SELECT 
        scenario_id,
        spr_id,
        mandant_id,
        scenario_descr

FROM DBP_DATA.AAD_SCENARIO_SPR_ZU ;