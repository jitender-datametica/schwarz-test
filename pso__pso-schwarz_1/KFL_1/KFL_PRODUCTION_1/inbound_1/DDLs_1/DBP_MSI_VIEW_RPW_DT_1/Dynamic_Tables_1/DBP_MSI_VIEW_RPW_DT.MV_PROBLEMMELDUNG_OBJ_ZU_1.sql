create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_PROBLEMMELDUNG_OBJ_ZU_1(
	SYSTEM_ID,
	MANDANT_ID,
	PROBLEMMELDUNG_ID,
	ZUS_OBJ_ID,
	WERT_DEC,
	WERT_DATE,
	WERT_CHAR
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
      SELECT
      7,
      mandant_id,
      problemmeldung_id,
      zus_obj_id,
      wert_dec,
      wert_date,
      wert_char
      FROM dbp_view.v_problemmeldung_obj_zu_1
      WHERE mandant_id = 1
 ;
