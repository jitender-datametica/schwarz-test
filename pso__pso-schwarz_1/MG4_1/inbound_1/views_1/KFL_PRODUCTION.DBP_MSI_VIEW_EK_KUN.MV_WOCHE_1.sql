create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_KUN.MV_WOCHE_1(
	GJWO,
	GJWO_VJ,
	KJWO,
	KJWO_VJ,
	WO_DAT_VON,
	WO_DAT_BIS,
	AKT_WO,
	AKT_WO_KOMPLETT,
	AKT_WO_KALENDARISCH
) as
SELECT
gjwo
,gjwo_vj
,kjwo
,kjwo_vj
,wo_dat_von
,wo_dat_bis
,akt_wo
,akt_wo_komplett
,akt_wo_kalendarisch
FROM dbp_view.v_woche_1
;