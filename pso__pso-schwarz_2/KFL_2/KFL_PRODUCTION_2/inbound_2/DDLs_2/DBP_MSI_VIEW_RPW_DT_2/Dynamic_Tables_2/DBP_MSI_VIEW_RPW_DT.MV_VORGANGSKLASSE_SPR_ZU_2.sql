create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_VORGANGSKLASSE_SPR_ZU_2(
	SYSTEM_ID,
	MANDANT_ID,
	VORGANGSKLASSE_ID,
	SPR_ID,
	VORGANGSKLASSE_BEZ,
	VORGANGSKLASSE_BEZ_KURZ,
	VORGANGSKLASSE_BEZ_LANG
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
          SELECT
          7,
          mandant_id,
          vorgangsklasse_id,
          spr_id,
          vorgangsklasse_bez,
          vorgangsklasse_bez_kurz,
          vorgangsklasse_bez_lang
          FROM dbp_view.v_vorgangsklasse_spr_zu_2
          WHERE mandant_id = 1
 ;
