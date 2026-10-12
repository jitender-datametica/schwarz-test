create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_L_PROBLEMMELDUNG_OBJ(
	SYSTEM_ID,
	MANDANT_ID,
	ZUS_OBJ_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
       SELECT
       7,
       mandant_id,
       zus_obj_id
       FROM dbp_view.v_l_problemmeldung_obj
       WHERE mandant_id = 1;
