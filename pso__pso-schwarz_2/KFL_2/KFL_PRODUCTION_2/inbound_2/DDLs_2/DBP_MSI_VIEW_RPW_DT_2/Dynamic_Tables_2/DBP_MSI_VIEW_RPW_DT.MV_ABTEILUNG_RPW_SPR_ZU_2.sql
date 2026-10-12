create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_ABTEILUNG_RPW_SPR_ZU_2(
	MANDANT_ID,
	ABTEILUNG_ID,
	SPR_ID,
	ABTEILUNG_RPW_BEZ,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
       SELECT
       mandant_id,
       abteilung_id,
       spr_id,
       abteilung_rpw_bez,
       7
       FROM dbp_view.v_abteilung_rpw_spr_zu_2
       WHERE mandant_id = 1
       AND spr_id = 22;
