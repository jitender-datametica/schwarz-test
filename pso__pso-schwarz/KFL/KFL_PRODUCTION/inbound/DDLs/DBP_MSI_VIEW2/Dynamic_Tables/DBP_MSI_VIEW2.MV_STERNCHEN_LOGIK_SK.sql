CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_STERNCHEN_LOGIK_SK
(
	ART_ID,
	MANDANT_ID,
	STERNCHEN_LOGIK_SK,
	SX_ID,
	S0_ID,
	S1_ID,
	S2_ID,
	S3_ID,
	S4_ID,
	S5_ID,
	S6_ID,
	S7_ID,
	S8_ID,
	S9_ID
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
sk.art_id, 
sk.mandant_id, 
MAX(sX_id) ||'/'    ||   MAX(s0_id) || '/'    ||   MAX(s1_id)||'/'|| MAX(s2_id)||'/'||MAX(s3_id)||'/'||MAX(s4_id)||'/'||MAX(s5_id)||'/'||MAX(s6_id)||'/'||MAX(s7_id)||'/'||MAX(s8_id)||'/'||MAX(s9_id) AS sternchen_logik_sk, 
MAX(sX_id), 
MAX(s0_id), 
MAX(s1_id), 
MAX(s2_id), 
MAX(s3_id), 
MAX(s4_id), 
MAX(s5_id), 
MAX(s6_id), 
MAX(s7_id), 
MAX(s8_id), 
MAX(s9_id)

FROM
   (
   SELECT
   lsl.art_id AS art_id, 
   lsl.mandant_id, 
   CAST (CASE lsl.sm_id WHEN -1 THEN ls.sternchen_id ELSE '  ' END AS CHAR(2)) AS sX_id, 
   CAST (CASE lsl.sm_id WHEN 0 THEN ls.sternchen_id ELSE '  ' END AS CHAR(2)) AS s0_id, 
   CAST (CASE lsl.sm_id WHEN 1 THEN ls.sternchen_id ELSE '  ' END AS CHAR(2)) AS s1_id, 
   CAST (CASE lsl.sm_id WHEN 2 THEN ls.sternchen_id ELSE '  ' END AS CHAR(2)) AS s2_id, 
   CAST (CASE lsl.sm_id WHEN 3 THEN ls.sternchen_id ELSE '  ' END AS CHAR(2)) AS s3_id, 
   CAST (CASE lsl.sm_id WHEN 4 THEN ls.sternchen_id ELSE '  ' END AS CHAR(2)) AS s4_id, 
   CAST (CASE lsl.sm_id WHEN 5 THEN ls.sternchen_id ELSE '  ' END AS CHAR(2)) AS s5_id, 
   CAST (CASE lsl.sm_id WHEN 6 THEN ls.sternchen_id ELSE '  ' END AS CHAR(2)) AS s6_id, 
   CAST (CASE lsl.sm_id WHEN 7 THEN ls.sternchen_id ELSE '  ' END AS CHAR(2)) AS s7_id, 
   CAST (CASE lsl.sm_id WHEN 8 THEN ls.sternchen_id ELSE '  ' END AS CHAR(2)) AS s8_id, 
   CAST (CASE lsl.sm_id WHEN 9 THEN ls.sternchen_id ELSE '  ' END AS CHAR(2)) AS s9_id

   FROM dbp_view.v_sternchen_logik AS lsl
   INNER JOIN dbp_view.v_l_sternchen AS ls
   ON  lsl.list_durchg_fg = ls.list_durchg_fg
   AND lsl.bezugsweg1_fg  = ls.bezugsweg1_fg
   AND lsl.bezugsweg4_fg  = ls.bezugsweg4_fg
   AND lsl.kdis0_fg       = ls.kdis0_fg
   AND lsl.kdis1_fg       = ls.kdis1_fg
   AND lsl.mandant_id     = ls.mandant_id

   WHERE lsl.mandant_id = 1) AS sk
   GROUP BY 1, 2;