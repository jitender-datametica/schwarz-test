create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_VF_2(
	VF_ID,
	VF_NAME,
	MANDANT_ID,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
   SELECT
      vf_id,
   vf_name,
   mandant_id,
   7
   FROM dbp_view.v_vf_2
   WHERE mandant_id = 1
 ;
