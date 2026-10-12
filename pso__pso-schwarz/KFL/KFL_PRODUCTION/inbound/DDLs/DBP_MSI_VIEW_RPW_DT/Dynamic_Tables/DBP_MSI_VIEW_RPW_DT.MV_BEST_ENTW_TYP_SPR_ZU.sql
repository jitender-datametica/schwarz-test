create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_BEST_ENTW_TYP_SPR_ZU(
	MANDANT_ID,
	BEST_ENTW_TYP_ID,
	BEST_ENTW_TYP_KBEZ,
	BEST_ENTW_TYP_BEZ
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as

       SELECT
       mandant_id,
       best_entw_typ_id,
       best_entw_typ_kbez,
       best_entw_typ_bez
FROM dbp_view.v_best_entw_typ_spr_zu

WHERE mandant_id = 1 AND spr_id = 22;
