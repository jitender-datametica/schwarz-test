CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GEKU_VTG_QUOTE
(
verteilgebiet_uid
,kjwo
,verteil_quote
,last_1_kjwo
,last_1_quote
,last_2_kjwo
,last_2_quote
,last_3_kjwo
,last_3_quote
)
AS
   SELECT  v011.verteilgebiet_uid, v011.kjwo, v011.verteil_quote, MAX(v011.last_1_kjwo) OVER (PARTITION BY verteilgebiet_uid) AS last_1_kjwo, MAX(v011.last_1_quote) OVER (PARTITION BY verteilgebiet_uid) AS last_1_quote, MAX(v011.last_2_kjwo) OVER (PARTITION BY verteilgebiet_uid) AS last_2_kjwo, MAX(v011.last_2_quote) OVER (PARTITION BY verteilgebiet_uid) AS last_2_quote, MAX(v011.last_3_kjwo) OVER (PARTITION BY verteilgebiet_uid) AS last_3_kjwo, MAX(v011.last_3_quote) OVER (PARTITION BY verteilgebiet_uid) AS last_3_quote
   FROM
   (
   SELECT  v01.verteilgebiet_uid, v01.kjwo, v01.verteil_quote, RANK() OVER (PARTITION BY CASE WHEN v01.verteil_quote IS NOT NULL THEN v01.verteilgebiet_uid END ORDER BY kjwo DESC NULLS LAST ) rank_kjwo, CASE WHEN rank_kjwo = 1 AND v01.verteil_quote IS NOT NULL THEN TRIM((MOD(v01.kjwo, 100))) || TRIM((v01.kjwo-200000) / 100) END::INTEGER AS last_1_kjwo, CASE WHEN rank_kjwo = 1 AND v01.verteil_quote IS NOT NULL THEN v01.verteil_quote END AS last_1_quote, CASE WHEN rank_kjwo = 2 AND v01.verteil_quote IS NOT NULL THEN TRIM((MOD(v01.kjwo, 100))) || TRIM((v01.kjwo-200000) / 100) END::INTEGER AS last_2_kjwo, CASE WHEN rank_kjwo = 2 AND v01.verteil_quote IS NOT NULL THEN v01.verteil_quote END AS last_2_quote, CASE WHEN rank_kjwo = 3 AND v01.verteil_quote IS NOT NULL THEN TRIM((MOD(v01.kjwo, 100))) || TRIM((v01.kjwo-200000) / 100) END::INTEGER AS last_3_kjwo, CASE WHEN rank_kjwo = 3 AND v01.verteil_quote IS NOT NULL THEN v01.verteil_quote END AS last_3_quote
   FROM dbp_msi_view_vis.ts_geku_verteilgebiet_quote v01
   --LEFT JOIN DBE_FED.geku_verteilgebiet v02
   --ON v01.verteilgebiet_uid = v02.verteilgebiet_uid
   ) v011;