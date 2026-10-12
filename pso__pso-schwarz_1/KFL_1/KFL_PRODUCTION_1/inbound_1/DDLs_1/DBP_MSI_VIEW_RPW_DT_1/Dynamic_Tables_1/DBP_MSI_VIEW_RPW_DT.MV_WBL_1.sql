create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_WBL_1(
	WBL_ID,
	MANDANT_ID,
	WBL_DAT_VON,
	WBL_NAME,
	GF_ID,
	EK_FG,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
       wbl_id,
    mandant_id,
    wbl_dat_von,
    wbl_name,
    gf_id,
    ek_fg,
    7
    FROM dbp_view.v_wbl_1
    WHERE mandant_id = 1
 ;
