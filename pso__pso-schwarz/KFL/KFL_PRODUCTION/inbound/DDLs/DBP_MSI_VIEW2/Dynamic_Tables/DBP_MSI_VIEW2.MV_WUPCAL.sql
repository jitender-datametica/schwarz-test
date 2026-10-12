CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_WUPCAL
(
	WUP_ID,
	MANDANT_ID,
	NB_ID,
	DAT,
	OFFEN,
	WERBEWOCHE,
	BONANZAHL,
	BONANZAHL_SUG,
	DATENLIEFERUNG,
	BONANZAHL_MISVIER,
	DATENLIEFERUNG_ARTBEW,
	DATENLIEFERUNG_BONANZAHL,
	DATENLIEFERUNG_MISVIER,
	DATENLIEFERUNG_QBM_STATUS,
	DAT_EXTRAKT_UMSATZ,
	WUP_BEREINIGT_FG,
	WUP_BEREINIGT_FG_VJ,
	WUP_BEREINIGT_FG_VJ_WO
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
   WITH t_wup_bereinigt AS(
    SELECT
        v01.dat, 
        v02.mandant_id,
        v02.wup_id,
        --INC11771013 Prescherad 06.10.2025 / Ersetzen umzugsfiliale_fg = 1 durch wup_aenderung_grund_id in (1,2,3,4) bzw umzugsfiliale_fg = 0 durch wup_aenderung_grund_id = 0
        CASE WHEN (v01.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v01.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) THEN 1 ELSE 0 END AS wup_bereinigt_fg_akt,
        CASE WHEN (v03.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v03.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) THEN 1 ELSE 0 END AS wup_bereinigt_fg_vj,
        CASE WHEN (v04.KJWO_KL_DAT_VON > (COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung) + 364) AND (v04.KJWO_KL_DAT_BIS < v02.dat_bis OR v02.wup_aenderung_grund_id IN (1,2,3,4))) THEN 1 ELSE 0 END AS wup_bereinigt_fg_vj_wo
    FROM dbp_view.v_tag v01
    JOIN dbp_view.v_wup v02
        ON (v01.dat >= COALESCE(v02.dat_eroeffnung_alt,v02.dat_eroeffnung))
    JOIN dbp_view.v_tag v03
        ON (v01.dat = v03.dat_vj_kt)
    JOIN dbp_view.v_tag v04
        ON (v01.dat = v04.dat_vj)
    WHERE v01.dat BETWEEN '2019-01-01' AND CURRENT_DATE()+7
        AND v02.nb_id = 0
        AND v02.mandant_id = 1
)
  
  SELECT
   v01.wup_id, 
   v01.mandant_id, 
   v01.nb_id, 
   v01.dat, 
   v01.offen, 
   v01.werbewoche, 
   v01.bonanzahl, 
   v01.bonanzahl_sug, 
   CASE WHEN v01.datenlieferung_artbew_wg_sum = 2 THEN 0
        WHEN v01.datenlieferung_artbew_wg_sum=3 THEN 0
        WHEN  TRY_TO_NUMERIC(v01.datenlieferung_artbew_wg_sum) IS NULL THEN 0
        ELSE v01.datenlieferung_artbew_wg_sum END, 
   v01.bonanzahl_misvier, 
   v01.datenlieferung_artbew, 
   v01.datenlieferung_bonanzahl, 
   v01.datenlieferung_misvier, 
   v01.datenlieferung_qbm_status, 
   v01.dat_extrakt_umsatz,
   v02.wup_bereinigt_fg_akt,
   v02.wup_bereinigt_fg_vj,
   v02.wup_bereinigt_fg_vj_wo

FROM dbp_view.v_wupcal v01
LEFT JOIN t_wup_bereinigt v02
ON v01.dat = v02.dat 
AND v01.mandant_id = v02.mandant_id 
AND v01.wup_id = v02.wup_id
WHERE v01.mandant_id = 1
AND v01.nb_id NOT IN (2,6,7);