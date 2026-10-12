create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW.MV_SPR_2(
	SPR_ID,
	SPR_NAME,
	SPR_ISO,
	DWH_SPR,
	SYSTEM_ID
) as
    SELECT
       spr_id,
    spr_name,
    spr_iso,
    dwh_spr,
    7
    FROM dbp_view.v_spr_2
    WHERE spr_id = 22
 ;
