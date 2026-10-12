create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_EK_GF_2(
	GF_ID,
	GF_NAME,
	MANDANT_ID,
	EK_FLG,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
          SELECT
            gf_id,
          gf_name,
          mandant_id,
          ek_fg,
          7 AS system_id
          FROM dbp_view.v_gf_2
          WHERE mandant_id=1
            AND ek_fg = 1
 ;
