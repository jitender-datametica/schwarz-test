create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_VKL_2(
	VKL_ID,
	GF_ID,
	VKL_NAME,
	MANDANT_ID,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
       SELECT
          vkl_id,
       gf_id,
       vkl_name,
       mandant_id,
       7 AS system_id
       FROM dbp_view.v_vkl_2
       WHERE  mandant_id = 1
 ;
