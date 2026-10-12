CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_WERBEWOCHE_WOCHE_KL_2
 (
	MANDANT_ID,
	AKT_KJWO_WW,
	AKT_KJWO_WW_KOMPLETT,
	KJWO_WW,
	WO_WW,
	WW_DAT_VON,
	WW_DAT_BIS,
	WW_MO
)
AS
SELECT
 DISTINCT ww.mandant_id
,ww.akt_kjwo_ww
,ww.akt_kjwo_ww_komplett
,ww.kjwo_ww
,SUBSTR(TO_CHAR(ww.kjwo_ww),5,2) AS wo_ww
,MIN(ww.dat) OVER (PARTITION BY ww.mandant_id, ww.kjwo_ww) AS ww_dat_von
,MAX(ww.dat) OVER (PARTITION BY ww.mandant_id, ww.kjwo_ww) AS ww_dat_bis
,(EXTRACT(YEAR FROM MIN(ww.dat) OVER (PARTITION BY ww.mandant_id, ww.kjwo_ww)) * 100) +
  EXTRACT(MONTH FROM MIN(ww.dat) OVER (PARTITION BY ww.mandant_id, ww.kjwo_ww)) AS ww_mo
FROM dbp_data.werbewoche_kl_2 ww
WHERE ww.mandant_id = 1;