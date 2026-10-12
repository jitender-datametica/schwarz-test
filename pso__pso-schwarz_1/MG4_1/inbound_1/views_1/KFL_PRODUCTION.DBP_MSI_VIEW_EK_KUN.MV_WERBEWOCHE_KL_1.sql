create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_KUN.MV_WERBEWOCHE_KL_1(
	MANDANT_ID,
	DAT,
	AKT_KJWO_WW,
	AKT_KJWO_WW_KOMPLETT,
	KJWO_WW
) as
SELECT 
mandant_id
,dat
,akt_kjwo_ww
,akt_kjwo_ww_komplett
,kjwo_ww
FROM dbp_view.v_werbewoche_kl_1
;