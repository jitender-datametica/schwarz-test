create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_GRUPPE_RPW_SPR_ZU(
	MANDANT_ID,
	GRUPPE_ID,
	ABTEILUNG_ID,
	SPR_ID,
	GRUPPE_RPW_BEZ,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
    mandant_id,
    gruppe_id,
    abteilung_id,
    spr_id,
    gruppe_rpw_bez,
    7
    FROM dbp_view.v_gruppe_rpw_spr_zu
    WHERE mandant_id = 1
    AND spr_id = 22;
