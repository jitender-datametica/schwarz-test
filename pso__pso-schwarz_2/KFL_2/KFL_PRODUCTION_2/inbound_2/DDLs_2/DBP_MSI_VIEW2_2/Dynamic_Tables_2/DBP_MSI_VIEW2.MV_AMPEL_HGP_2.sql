CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_AMPEL_HGP_2
(
	MANDANT_ID,
	HGP_ID,
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
	SW_UMSATZ_UNTEN,
	EK_MEP,
	EK_MEP_VJ,
	ROHERTRAG,
	ROHERTRAG_VJ,
	SW_ROHERTRAG_UNTEN,
	SPANNE,
	SPANNE_VJ,
	SW_SPANNE_UNTEN,
	WE_UMSATZ,
	WE_UMSATZ_VJ,
	SW_WE_UMSATZ_UNTEN
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
dt1.mandant_id, 
t5.hgp_id, 
dt1.kj, 
SUM(umsatz_netto) ums_sort, 
1 AS kl_id, 
CASE WHEN SUM((umsatz_netto_vj)+(ABS(umsatz_netto_vj)*(sw_umsatz_oben)))<=SUM(umsatz_netto) THEN 1
     WHEN SUM((umsatz_netto_vj)+(ABS(umsatz_netto_vj)*(sw_umsatz_unten)))<SUM(umsatz_netto) THEN 2
     WHEN SUM((umsatz_netto_vj)+(ABS(umsatz_netto_vj)*(sw_umsatz_unten)))>= SUM(umsatz_netto) THEN 3
     ELSE 4 END AS ampel_umsatz, 
SUM((umsatz_netto_vj)+(ABS(umsatz_netto_vj)*(sw_umsatz_oben))) AS sw_umsatz_oben, 
CASE WHEN SUM(we_umsatz_vj+(ABS(we_umsatz_vj)*sw_we_umsatz_oben))<=SUM(we_umsatz) THEN 1
     WHEN SUM(we_umsatz_vj+(ABS(we_umsatz_vj)*sw_we_umsatz_unten))<SUM(we_umsatz) THEN 2
     WHEN SUM(we_umsatz_vj+(ABS(we_umsatz_vj)*sw_we_umsatz_unten))>= SUM(we_umsatz) THEN 3
     ELSE 4 END AS ampel_we_umsatz, 
SUM(we_umsatz_vj+(ABS(we_umsatz_vj)*sw_we_umsatz_oben)) AS sw_we_umsatz_oben, 
CASE WHEN SUM((umsatz_netto_vj-ek_mep_vj)+(ABS(umsatz_netto_vj-ek_mep_vj)*(sw_rohertrag_oben)))<=SUM(umsatz_netto-ek_mep) THEN 1
     WHEN SUM((umsatz_netto_vj-ek_mep_vj)+(ABS(umsatz_netto_vj-ek_mep_vj)*(sw_rohertrag_unten)))<SUM(umsatz_netto-ek_mep) THEN 2
     WHEN SUM((umsatz_netto_vj-ek_mep_vj)+(ABS(umsatz_netto_vj-ek_mep_vj)*(sw_rohertrag_unten)))>= SUM(umsatz_netto-ek_mep) THEN 3
     ELSE 4 END AS ampel_rohertrag, 
SUM((umsatz_netto_vj-ek_mep_vj)+(ABS(umsatz_netto_vj-ek_mep_vj)*(sw_rohertrag_oben))) AS sw_rohertrag_oben, 
CASE WHEN ((SUM(umsatz_netto*sw_spanne_oben)/SUM(umsatz_netto)) + (SUM(umsatz_netto_vj-ek_mep_vj)/SUM(umsatz_netto_vj))) <=(SUM(umsatz_netto-ek_mep)/SUM(umsatz_netto)) THEN 1
     WHEN ((SUM(umsatz_netto*sw_spanne_unten)/SUM(umsatz_netto)) + (SUM(umsatz_netto_vj-ek_mep_vj)/SUM(umsatz_netto_vj))) < (SUM(umsatz_netto-ek_mep)/SUM(umsatz_netto))  THEN 2
     WHEN ((SUM(umsatz_netto*sw_spanne_unten)/SUM(umsatz_netto)) + (SUM(umsatz_netto_vj-ek_mep_vj)/SUM(umsatz_netto_vj))) >= (SUM(umsatz_netto-ek_mep)/SUM(umsatz_netto))  THEN 3
     ELSE 4 END AS ampel_spanne, 
(SUM(umsatz_netto*sw_spanne_oben)/SUM(umsatz_netto)) + (SUM(umsatz_netto_vj-ek_mep_vj)/SUM(umsatz_netto_vj)) AS sw_spanne_oben, 
CASE WHEN MAX(sw_fg) = 1 THEN 'X' ELSE ' ' END AS sw_fg, 
SUM(umsatz_netto) AS umsatz_netto, 
SUM(umsatz_netto_vj) AS umsatz_netto_vj, 
SUM((umsatz_netto_vj)+(ABS(umsatz_netto_vj)*(sw_umsatz_unten))) AS sw_umsatz_unten, 
SUM(ek_mep) AS ek_mep, 
SUM(ek_mep_vj) AS ek_mep_vj, 
SUM(umsatz_netto-ek_mep) AS rohertrag, 
SUM(umsatz_netto_vj-ek_mep_vj) AS rohertrag_vj, 
SUM((umsatz_netto_vj-ek_mep_vj)+(ABS(umsatz_netto_vj-ek_mep_vj)*(sw_rohertrag_unten))) AS sw_rohertrag_unten, 
SUM(umsatz_netto-ek_mep)/SUM(umsatz_netto) AS spanne, 
SUM(umsatz_netto_vj-ek_mep_vj)/SUM(umsatz_netto_vj) AS spanne_vj, 
SUM(umsatz_netto*sw_spanne_unten)/SUM(umsatz_netto) AS sw_spanne_unten, 
SUM(we_umsatz) AS we_umsatz, 
SUM(we_umsatz_vj) AS we_umsatz_vj, 
SUM(we_umsatz_vj+(ABS(we_umsatz_vj)*sw_we_umsatz_unten)) AS sw_we_umsatz_unten

   FROM
   (SELECT
   t01.gp_id, 
   t01.kj, 
   t01.mandant_id, 
   MAX(sw_fg) AS sw_fg, 
   SUM(CASE WHEN sw_id = 1 THEN CAST(sw_oben AS DECIMAL(18,4))ELSE 0 END) AS sw_rohertrag_oben, 
   SUM(CASE WHEN sw_id = 1 THEN CAST(sw_unten AS DECIMAL(18,4)) ELSE 0 END) AS sw_rohertrag_unten, 
   SUM(CASE WHEN sw_id = 2 THEN CAST(sw_oben AS DECIMAL(18,4))ELSE 0 END) AS sw_spanne_oben, 
   SUM(CASE WHEN sw_id = 2 THEN CAST(sw_unten AS DECIMAL(18,4)) ELSE 0 END) AS sw_spanne_unten, 
   SUM(CASE WHEN sw_id = 3 THEN CAST(sw_oben  AS DECIMAL(18,4))ELSE 0 END) AS sw_umsatz_oben, 
   SUM(CASE WHEN sw_id = 3 THEN CAST(sw_unten AS DECIMAL(18,4)) ELSE 0 END) AS sw_umsatz_unten, 
   SUM(CASE WHEN sw_id = 4 THEN CAST(sw_oben  AS DECIMAL(18,4))ELSE 0 END) AS sw_we_umsatz_oben, 
   SUM(CASE WHEN sw_id = 4 THEN CAST(sw_unten AS DECIMAL(18,4)) ELSE 0 END) AS sw_we_umsatz_unten
   FROM dbp_view.v_gp_schwellwert_zu_2 t01
   WHERE t01.gp_id > 999999
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
   FROM dbp_view.v_bsch_rech_det_gp_sum_2 t1_2
   INNER JOIN
   (
   SELECT kj, dat dat_join, 1 AS akt_fg, 0 AS vj_fg FROM dbp_view.v_tag_2 WHERE dat < CURRENT_DATE AND akt_kj IN (0,-1)
   UNION
   SELECT kj, dat_vj dat_join, 0 AS akt_fg, 1 AS vj_fg FROM dbp_view.v_tag_2 WHERE dat < CURRENT_DATE AND akt_kj IN (0,-1)
   ) t2
   ON t1.dat = t2.dat_join
   GROUP BY 1,2,3
   )dt2
   ON  dt1.gp_id = dt2.gp_id
   AND dt1.mandant_id = dt2.mandant_id
   AND dt1.kj = dt2.kj
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
   FROM dbp_view.v_artbew_gp_sum_2 t3
   INNER JOIN
   (
   SELECT kj, dat dat_join, 1 AS akt_fg, 0 AS vj_fg FROM dbp_view.v_tag_2 WHERE dat < CURRENT_DATE AND akt_kj IN (0,-1)
   UNION
   SELECT kj, dat_vj dat_join, 0 AS akt_fg, 1 AS vj_fg FROM dbp_view.v_tag_2 WHERE dat < CURRENT_DATE AND akt_kj IN (0,-1)
   ) t4
   ON t3.dat = t4.dat_join
   GROUP BY 1,2,3
   )dt3
   ON  dt1.gp_id = dt3.gp_id
   AND dt1.mandant_id = dt3.mandant_id
   AND dt1.kj = dt3.kj
   INNER JOIN dbp_view.v_gp_2 t5
   ON  dt1.mandant_id = t5.mandant_id
   AND dt1.gp_id = t5.gp_id
   GROUP BY 1,2,3,5;