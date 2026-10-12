create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_BELEG_ALTER_SPR_ZU_1(
	MANDANT_ID,
	BELEG_ALTER_ID,
	SPR_ID,
	BELEG_ALTER_BEZ,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
   SELECT
    mandant_id,
   beleg_alter_id,
   spr_id,
   beleg_alter_bez,
   7
  FROM dbp_view.v_beleg_alter_spr_zu_1
  WHERE spr_id = 22
    AND mandant_id = 1
 ;
