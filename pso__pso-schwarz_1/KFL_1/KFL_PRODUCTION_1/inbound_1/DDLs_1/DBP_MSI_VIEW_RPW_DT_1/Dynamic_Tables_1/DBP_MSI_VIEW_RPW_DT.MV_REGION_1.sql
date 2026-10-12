create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_REGION_1(
	REGION_ID,
	SAP_REGION_ID,
	LAND_ID,
	REGION_NAME,
	MANDANT_ID,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
   SELECT
     region_id,
   sap_region_id,
   land_id,
   region_name,
   mandant_id,
   7 AS system_id
   FROM dbp_view.v_region_1
   WHERE mandant_id = 1
;
