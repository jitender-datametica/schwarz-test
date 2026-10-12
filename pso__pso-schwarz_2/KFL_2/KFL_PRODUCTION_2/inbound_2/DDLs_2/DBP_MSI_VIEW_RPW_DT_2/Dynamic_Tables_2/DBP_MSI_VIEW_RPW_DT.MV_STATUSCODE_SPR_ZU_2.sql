create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_STATUSCODE_SPR_ZU_2(
	MANDANT_ID,
	STATUSCODE_ID,
	SPR_ID,
	STATUSCODE_BEZ,
	STATUSCODE_BEZ_KURZ,
	STATUSCODE_BEZ_LANG,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
          SELECT
          mandant_id,
          statuscode_id,
          spr_id,
          statuscode_bez,
          statuscode_bez_kurz,
          statuscode_bez_lang,
          7
          FROM dbp_view.v_statuscode_spr_zu_2
          WHERE mandant_id = 1
          AND spr_id = 22
 ;
