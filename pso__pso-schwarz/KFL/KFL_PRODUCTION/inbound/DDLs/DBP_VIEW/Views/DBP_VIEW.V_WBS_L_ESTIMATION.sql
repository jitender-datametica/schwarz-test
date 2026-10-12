create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_WBS_L_ESTIMATION(
	MANDANT_ID,
	ESTIMATION_ID,
	ESTIMATION_BEZ
) as 
    SELECT 
        mandant_id,
        estimation_id,
        estimation_bez

FROM DBP_DATA.WBS_L_ESTIMATION ;
