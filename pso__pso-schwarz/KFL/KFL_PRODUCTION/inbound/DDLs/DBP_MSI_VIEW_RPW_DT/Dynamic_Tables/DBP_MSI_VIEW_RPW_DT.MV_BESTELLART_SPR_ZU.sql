create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_BESTELLART_SPR_ZU(
	MANDANT_ID,
	BESTELLART_ID,
	SPR_ID,
	BESTELLART_BEZ,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
    mandant_id,
    bestellart_id,
    spr_id,
    bestellart_bez,
    7
    FROM dbp_view.v_bestellart_spr_zu
    WHERE spr_id = 22
    AND mandant_id = 1;
