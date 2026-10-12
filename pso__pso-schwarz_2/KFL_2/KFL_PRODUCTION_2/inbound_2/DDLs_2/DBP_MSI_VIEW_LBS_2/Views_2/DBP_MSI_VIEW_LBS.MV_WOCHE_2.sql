CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_WOCHE_2(
	GJWO,
	GJWO_VJ,
	KJWO,
	KJWO_VJ,
	KJWO_VVJ,
	WO_DAT_VON,
	WO_DAT_BIS,
	AKT_WO,
	AKT_WO_KOMPLETT,
	AKT_WO_KALENDARISCH
) AS SELECT
    gjwo,
    gjwo_vj,
    kjwo,
    kjwo_vj,
    kjwo_vvj,
    wo_dat_von,
    wo_dat_bis,
    akt_wo,
    akt_wo_komplett,
    akt_wo_kalendarisch
FROM dbp_view.v_woche_2;