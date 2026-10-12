create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_RECH_BELEG_STATUS_SPR_ZU_2(
	SYSTEM_ID,
	MANDANT_ID,
	RECH_BELEG_STATUS_ID,
	SPR_ID,
	RECH_BELEG_STATUS_BEZ
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
    7,
    mandant_id,
    rech_beleg_status_id,
    spr_id,
    rech_beleg_status_bez
    FROM dbp_view.v_rech_beleg_status_spr_zu_2
    WHERE spr_id =22
    AND mandant_id = 1
 ;
