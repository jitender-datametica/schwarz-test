create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_ZAHLART_SPR_ZU_1(
	MANDANT_ID,
	ZAHLART_ID,
	SPR_ID,
	ZAHLART_BEZ,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
                   SELECT
                   mandant_id,
                   zahlart_id,
                   spr_id,
                   zahlart_bez,
                   7
FROM dbp_view.v_zahlart_spr_zu_1
WHERE mandant_id = 1
AND   spr_id = 22
 ;
