create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_VORGANGSART_AG08_SPR_ZU(
	SYSTEM_ID,
	MANDANT_ID,
	VORGANGSART_AG08_ID,
	SPR_ID,
	VORGANGSART_AG08_BEZ
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
    7,
    mandant_id,
    vorgangsart_ag08_id,
    spr_id,
    vorgangsart_ag08_bez
    FROM dbp_view.v_vorgangsart_ag08_spr_zu
    WHERE  mandant_id = 1
    AND spr_id=22;
