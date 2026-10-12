CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_AMPEL_GP_1
(
	MANDANT_ID,
	GP_ID,
	KJ,
	UMS_SORT,
	KL_ID,
	AMPEL_UMSATZ,
	SW_UMSATZ_OBEN,
	AMPEL_WE_UMSATZ,
	SW_WE_UMSATZ_OBEN,
	AMPEL_ROHERTRAG,
	SW_ROHERTRAG_OBEN,
	AMPEL_SPANNE,
	SW_SPANNE_OBEN,
	SW_FG,
	UMSATZ_NETTO,
	UMSATZ_NETTO_VJ,
	PROZ_SW_UMSATZ_OBEN,
	PROZ_SW_UMSATZ_UNTEN,
	EK_MEP,
	EK_MEP_VJ,
	ROHERTRAG,
	ROHERTRAG_VJ,
	PROZ_SW_ROHERTRAG_OBEN,
	PROZ_SW_ROHERTRAG_UNTEN,
	SPANNE,
	SPANNE_VJ,
	PROZ_SW_SPANNE_OBEN,
	PROZ_SW_SPANNE_UNTEN,
	WE_UMSATZ,
	WE_UMSATZ_VJ,
	PROZ_SW_WE_UMSATZ_OBEN,
	PROZ_SW_WE_UMSATZ_UNTEN
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
dt1.mandant_id, 
dt1.gp_id, 
dt1.kj, 
umsatz_netto AS ums_sort, 
1 AS KL_ID, 
CASE WHEN (umsatz_netto_vj)+(ABS(umsatz_netto_vj)*(sw_umsatz_oben))<=umsatz_netto THEN 1
     WHEN  (umsatz_netto_vj)+(ABS(umsatz_netto_vj)*(sw_umsatz_unten))<umsatz_netto THEN 2
     WHEN  (umsatz_netto_vj)+(ABS(umsatz_netto_vj)*(sw_umsatz_unten))>= umsatz_netto THEN 3
     ELSE 4 END AS ampel_umsatz, 
(umsatz_netto_vj)+(ABS(umsatz_netto_vj)*(sw_umsatz_oben)) AS sw_umsatz_oben, 
CASE WHEN we_umsatz_vj+(ABS(we_umsatz_vj)*sw_we_umsatz_oben) <=we_umsatz THEN 1
     WHEN we_umsatz_vj+(ABS(we_umsatz_vj)*sw_we_umsatz_unten) <we_umsatz THEN 2
     WHEN we_umsatz_vj+(ABS(we_umsatz_vj)*sw_we_umsatz_unten) >= we_umsatz THEN 3
     ELSE 4 END AS ampel_we_umsatz, 
we_umsatz_vj+(ABS(we_umsatz_vj)*sw_we_umsatz_oben) AS sw_we_umsatz_oben, 
CASE WHEN (umsatz_netto_vj-ek_mep_vj)+(ABS(umsatz_netto_vj-ek_mep_vj)*(sw_rohertrag_oben))<=umsatz_netto-ek_mep THEN 1
     WHEN (umsatz_netto_vj-ek_mep_vj)+(ABS(umsatz_netto_vj-ek_mep_vj)*(sw_rohertrag_unten))<umsatz_netto-ek_mep THEN 2
     WHEN (umsatz_netto_vj-ek_mep_vj)+(ABS(umsatz_netto_vj-ek_mep_vj)*(sw_rohertrag_unten))>= umsatz_netto-ek_mep THEN 3
     ELSE 4 END AS ampel_rohertrag, 
(umsatz_netto_vj-ek_mep_vj)+(ABS(umsatz_netto_vj-ek_mep_vj)*(sw_rohertrag_oben)) AS sw_rohertrag_oben, 
CASE WHEN ((umsatz_netto_vj-ek_mep_vj)/umsatz_netto_vj)+sw_spanne_oben<= (umsatz_netto-ek_mep)/umsatz_netto THEN 1
     WHEN ((umsatz_netto_vj-ek_mep_vj)/umsatz_netto_vj)+sw_spanne_unten< (umsatz_netto-ek_mep)/umsatz_netto  THEN 2
     WHEN ((umsatz_netto_vj-ek_mep_vj)/umsatz_netto_vj)+sw_spanne_unten>= (umsatz_netto-ek_mep)/umsatz_netto  THEN 3
     ELSE 4 END AS ampel_spanne, 
((umsatz_netto_vj-ek_mep_vj)/umsatz_netto_vj)+sw_spanne_oben AS sw_spanne_oben, 
CASE WHEN sw_fg=1 THEN 'X' ELSE ' ' END AS sw_fg, 
umsatz_netto, 
umsatz_netto_vj, 
sw_umsatz_oben AS proz_sw_umsatz_oben, 
sw_umsatz_unten AS proz_sw_umsatz_unten, 
ek_mep, ek_mep_vj, 
(umsatz_netto-ek_mep) AS rohertrag, 
(umsatz_netto_vj-ek_mep_vj) AS rohertrag_vj, 
sw_rohertrag_oben AS proz_sw_rohertrag_oben, 
sw_rohertrag_unten AS proz_sw_rohertrag_unten, 
(umsatz_netto-ek_mep)/umsatz_netto spanne, 
(umsatz_netto_vj-ek_mep_vj)/umsatz_netto_vj AS spanne_vj, 
sw_spanne_oben AS proz_sw_spanne_oben, 
sw_spanne_unten AS proz_sw_spanne_unten, 
we_umsatz, 
we_umsatz_vj, 
sw_we_umsatz_oben AS proz_sw_we_umsatz_oben, 
sw_we_umsatz_unten AS proz_sw_we_umsatz_unten

FROM
   (SELECT
   gp_id, kj, 
   mandant_id, 
   MAX(sw_fg) AS sw_fg, 
   SUM(CASE WHEN sw_id = 1 THEN CAST(sw_oben  AS DECIMAL(18,4))ELSE 0 END) AS sw_rohertrag_oben, 
   SUM(CASE WHEN sw_id = 1 THEN CAST(sw_unten AS DECIMAL(18,4)) ELSE 0 END) AS sw_rohertrag_unten, 
   SUM(CASE WHEN sw_id = 2 THEN CAST(sw_oben  AS DECIMAL(18,4))ELSE 0 END) AS sw_spanne_oben, 
   SUM(CASE WHEN sw_id = 2 THEN CAST(sw_unten AS DECIMAL(18,4)) ELSE 0 END) AS sw_spanne_unten, 
   SUM(CASE WHEN sw_id = 3 THEN CAST(sw_oben  AS DECIMAL(18,4))ELSE 0 END) AS sw_umsatz_oben, 
   SUM(CASE WHEN sw_id = 3 THEN CAST(sw_unten AS DECIMAL(18,4)) ELSE 0 END) AS sw_umsatz_unten, 
   SUM(CASE WHEN sw_id = 4 THEN CAST(sw_oben  AS DECIMAL(18,4))ELSE 0 END) AS sw_we_umsatz_oben, 
   SUM(CASE WHEN sw_id = 4 THEN CAST(sw_unten AS DECIMAL(18,4)) ELSE 0 END) AS sw_we_umsatz_unten
   FROM dbp_view.v_gp_schwellwert_zu_1
   WHERE gp_id>999999
   GROUP BY 1,2,3
   )dt1
   LEFT OUTER JOIN
   (
   SELECT
   t2.kj, 
   t1.gp_id, 
   t1.mandant_id, 
   CASE WHEN SUM(ek_n*akt_fg) = 0 THEN NULL ELSE SUM(ek_n*akt_fg) END AS we_umsatz, 
   CASE WHEN SUM(ek_n*vj_fg) = 0 THEN NULL ELSE SUM(ek_n*vj_fg) END AS we_umsatz_vj
   FROM dbp_view.v_bsch_rech_det_gp_sum_1 t1_1
   INNER JOIN
   (
   SELECT kj, dat dat_join, 1 AS akt_fg, 0 AS vj_fg FROM dbp_view.v_tag_1 WHERE dat < CURRENT_DATE AND akt_kj IN (0,-1)
   UNION
   SELECT kj, dat_vj dat_join, 0 AS akt_fg, 1 AS vj_fg FROM dbp_view.v_tag_1 WHERE dat < CURRENT_DATE AND akt_kj IN (0,-1)
   ) t2
   ON t1.dat=t2.dat_join
   GROUP BY 1,2,3
   )dt2
   ON dt1.gp_id=dt2.gp_id
   AND dt1.mandant_id=dt2.mandant_id
   AND dt1.kj=dt2.kj
   LEFT OUTER JOIN
   (
   SELECT
   t4.kj, 
   t3.gp_id, 
   t3.mandant_id, 
   CASE WHEN SUM((umsatz_netto+diff_umsatz_netto_konz)*akt_fg) = 0 THEN NULL ELSE SUM((umsatz_netto+diff_umsatz_netto_konz)*akt_fg) END AS umsatz_netto, 
   CASE WHEN SUM((umsatz_netto+diff_umsatz_netto_konz)*vj_fg) = 0 THEN NULL ELSE SUM((umsatz_netto+diff_umsatz_netto_konz)*vj_fg) END AS umsatz_netto_vj, 
   CASE WHEN SUM((ek_mep+diff_ek_mep_konz)*akt_fg) = 0 THEN NULL ELSE SUM((ek_mep+diff_ek_mep_konz)*akt_fg) END AS ek_mep, 
   CASE WHEN SUM((ek_mep+diff_ek_mep_konz)*vj_fg) = 0 THEN NULL ELSE SUM((ek_mep+diff_ek_mep_konz)*vj_fg) END AS ek_mep_vj
   FROM dbp_view.v_artbew_gp_sum_1 t3
   INNER JOIN
   (
   SELECT kj, dat dat_join, 1 AS akt_fg, 0 AS vj_fg FROM dbp_view.v_tag_1 WHERE dat < CURRENT_DATE AND akt_kj IN (0,-1)
   UNION
   SELECT kj, dat_vj dat_join, 0 AS akt_fg, 1 AS vj_fg FROM dbp_view.v_tag_1 WHERE dat < CURRENT_DATE AND akt_kj IN (0,-1)
   ) t4
   ON t3.dat=t4.dat_join
   GROUP BY 1,2,3
   )dt3
   ON dt1.gp_id=dt3.gp_id
   AND dt1.mandant_id=dt3.mandant_id
   AND dt1.kj=dt3.kj;