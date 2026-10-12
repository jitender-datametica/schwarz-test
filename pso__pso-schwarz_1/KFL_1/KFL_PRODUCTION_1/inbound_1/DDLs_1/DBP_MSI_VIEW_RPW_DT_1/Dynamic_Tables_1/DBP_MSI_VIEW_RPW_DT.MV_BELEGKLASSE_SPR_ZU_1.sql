create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_BELEGKLASSE_SPR_ZU_1(
	MANDANT_ID,
	BELEGKLASSE_ID,
	SPR_ID,
	BELEGKLASSE_BEZ,
	BELEGKLASSE_BEZ_KURZ,
	BELEGKLASSE_BEZ_LANG,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
       SELECT
         mandant_id,
       belegklasse_id,
       spr_id,
       belegklasse_bez,
       belegklasse_bez_kurz,
       belegklasse_bez_lang,
       7
       FROM dbp_view.v_belegklasse_spr_zu_1
       WHERE mandant_id = 1
         AND spr_id = 22
 ;
