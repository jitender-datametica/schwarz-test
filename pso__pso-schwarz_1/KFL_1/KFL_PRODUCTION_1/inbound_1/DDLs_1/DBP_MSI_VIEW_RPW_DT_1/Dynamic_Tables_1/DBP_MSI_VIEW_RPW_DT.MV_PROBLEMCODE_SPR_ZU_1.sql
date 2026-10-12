create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_PROBLEMCODE_SPR_ZU_1(
	MANDANT_ID,
	PROBLEMCODE_ID,
	SPR_ID,
	PROBLEMCODE_BEZ,
	PROBLEMCODE_BEZ_KURZ,
	PROBLEMCODE_BEZ_LANG,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
    mandant_id,
    problemcode_id,
    spr_id,
    problemcode_bez,
    problemcode_bez_kurz,
    problemcode_bez_lang,
    7
    FROM dbp_view.v_problemcode_spr_zu_1
    WHERE mandant_id = 1
    AND spr_id = 22
 ;
