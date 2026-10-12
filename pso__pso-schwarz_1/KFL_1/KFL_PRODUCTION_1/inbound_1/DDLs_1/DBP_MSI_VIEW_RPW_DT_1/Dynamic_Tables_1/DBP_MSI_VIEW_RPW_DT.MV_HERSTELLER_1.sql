create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_HERSTELLER_1(
	HERST_ID,
	HERST_NAME,
	MANDANT_ID,
	STRASSE,
	PLZ,
	ORT,
	LAND_ID,
	HERST_FG,
	AMPEL_FLG,
	SYSTEM_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
       g.gp_id,
    gp_name,
    mandant_id,
    gp_strasse,
    gp_plz,
    gp_ort,
    land_id,
    herst_fg,
    1 AS ampel_flg,
    7 AS system_id
    FROM dbp_view.v_gp_1 g
    WHERE mandant_id = 1
      AND herst_fg = 1
 ;
