create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_GP_FEHLERART_SPR_ZU_2(
	SYSTEM_ID,
	MANDANT_ID,
	GP_FEHLERART_ID,
	SPR_ID,
	GP_FEHLERART_BEZ
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
          SELECT
          7,
          mandant_id,
          CASE WHEN gp_fehlerart_id= '' THEN  '0' ELSE gp_fehlerart_id END gp_fehlerart_id,
          spr_id,
          gp_fehlerart_bez
          FROM dbp_view.v_gp_fehlerart_spr_zu_2
          WHERE mandant_id = 1
          AND  spr_id = 22;
