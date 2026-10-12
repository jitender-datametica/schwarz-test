create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_PROBLEMKLASSE_SPR_ZU_1(
	MANDANT_ID,
	PROBLEMKLASSE_ID,
	SPR_ID,
	PROBLEMKLASSE_BEZ,
	PROBLEMKLASSE_BEZ_KURZ,
	PROBLEMKLASSE_BEZ_LANG,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
    mandant_id,
    problemklasse_id,
    spr_id,
    problemklasse_bez,
    problemklasse_bez_kurz,
    problemklasse_bez_lang,
    7
    FROM dbp_view.v_problemklasse_spr_zu_1
    WHERE mandant_id = 1
    AND spr_id = 22
 ;
