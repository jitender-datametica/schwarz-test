create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_BUCH_GRUND_INT_SPR_ZU_2(
	SYSTEM_ID,
	MANDANT_ID,
	BUCH_GRUND_INT_ID,
	SPR_ID,
	BUCH_GRUND_INT_BEZ
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
                SELECT
                7,
                mandant_id,
                buch_grund_int_id,
                spr_id,
                buch_grund_int_bez
                FROM dbp_view.v_buch_grund_int_spr_zu_2
                WHERE mandant_id = 1
                AND  spr_id = 22;
