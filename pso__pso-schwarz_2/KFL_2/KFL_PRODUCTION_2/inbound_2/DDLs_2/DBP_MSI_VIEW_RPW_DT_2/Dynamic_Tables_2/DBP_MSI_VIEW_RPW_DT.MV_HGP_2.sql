create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_HGP_2(
	HGP_ID,
	HGP_NAME,
	MANDANT_ID,
	SYSTEM_ID,
	ZEK_ID,
	LOESCH_FG,
	GP_BRANCHE_ID
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
    gp_id,
    CASE WHEN loesch_fg = 1
    THEN  '{' || gp_name  || '}'
    ELSE  gp_name
    END AS gp_name,
    mandant_id,
    7,
    zek_id,
    COALESCE (loesch_fg, 0) AS loesch_fg,
    gp_branche_id
    FROM dbp_view.v_gp_2
    WHERE mandant_id = 1
    AND  (gp_id > 99999 AND gp_id < 1000000) OR gp_id BETWEEN 9211 AND 9220;
