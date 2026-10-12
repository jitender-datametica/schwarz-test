create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_WERBEWOCHE_KL_1(
	MANDANT_ID,
	DAT,
	AKT_KJWO_WW,
	AKT_KJWO_WW_KOMPLETT,
	KJWO_WW,
	WO_WW
) as
   SELECT
   mandant_id, dat, akt_kjwo_ww, akt_kjwo_ww_komplett, kjwo_ww, kjwo_ww AS wo_ww
   FROM dbp_view.v_werbewoche_kl_1;