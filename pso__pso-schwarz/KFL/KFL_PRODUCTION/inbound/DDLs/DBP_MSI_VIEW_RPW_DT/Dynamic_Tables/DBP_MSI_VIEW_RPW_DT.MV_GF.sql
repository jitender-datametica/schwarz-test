create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_GF(
	GF_ID,
	MANDANT_ID,
	EK_FG,
	GF_NAME,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as

    SELECT
    gf_id,
    mandant_id,
    ek_fg,
    gf_name,
    7
FROM dbp_view.v_gf

WHERE mandant_id = 1
AND ek_fg = 0;
