CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_WERBEWOCHE_WOCHE_KL_2
(
 mandant_id
,akt_kjwo_ww
,akt_kjwo_ww_komplett
,kjwo_ww
,wo_ww
,ww_dat_von
,ww_dat_bis
,ww_mo
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
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
FROM dbp_view.v_werbewoche_kl_2 ww;