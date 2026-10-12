create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_L_BEST_ENTW_TYP_1(
	MANDANT_ID,
	BEST_ENTW_TYP_ID,
	NACHBELASTUNG_FG,
	PREIS_PRUEFEN_FG
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
    SELECT
    mandant_id,
    best_entw_typ_id,
    nachbelastung_fg,
    preis_pruefen_fg
    FROM dbp_view.v_l_best_entw_typ_1
    WHERE mandant_id = 1;
