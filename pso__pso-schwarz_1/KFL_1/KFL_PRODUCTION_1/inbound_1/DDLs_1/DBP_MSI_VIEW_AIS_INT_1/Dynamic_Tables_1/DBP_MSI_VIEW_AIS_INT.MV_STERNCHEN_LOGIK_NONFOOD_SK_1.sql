CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_STERNCHEN_LOGIK_NONFOOD_SK_1
(
art_id
, mandant_id
, sternchen_logik_sk
, kl_id
, sx_id
, s0_id
, s1_id
, s2_id
, s3_id
, s4_id
, s5_id
, s6_id
, s7_id
, s8_id
, s9_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
   SELECT
   sk.art_id, 
   sk.mandant_id, 
   MAX(sX_id)  || '/'  ||   MAX(s0_id)||  '/' ||  MAX(s1_id)||  '/'  ||  MAX(s2_id)||'/'||MAX(s3_id)||'/'||MAX(s4_id)||'/'||MAX(s5_id) || '/'  ||   MAX(s6_id)||  '/' || MAX(s7_id) || '/'  ||   MAX(s8_id)||  '/' || MAX(s9_id), 1, MAX(sX_id), MAX(s0_id), MAX(s1_id), MAX(s2_id), MAX(s3_id), MAX(s4_id), MAX(s5_id), MAX(s6_id), MAX(s7_id), MAX(s8_id), MAX(s9_id)
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

   FROM
   (
   SELECT
   art_id, 
   sm_id, 
   mandant_id, 
   CASE WHEN SUM(list_durchg_fg) = COUNT(list_durchg_fg) THEN 1 ELSE 0 END list_durchg_fg, 
   CASE WHEN SUM(bezugsweg1_fg) = COUNT(bezugsweg1_fg) THEN 1 ELSE 0 END bezugsweg1_fg, 
   CASE WHEN SUM(bezugsweg4_fg) = COUNT(bezugsweg4_fg) THEN 1 ELSE 0 END bezugsweg4_fg, 
   CASE WHEN Sum(kdis0_fg) = Count(kdis0_fg) THEN 1 ELSE 0 END kdis0_fg, 
   CASE WHEN Sum(kdis1_fg) = COUNT(kdis1_fg) THEN 1 ELSE 0 END kdis1_fg, 
   SUM(anzahl_markt_soll) anzahl_markt_soll

   FROM dbp_view.v_sternchen_logik_1

   GROUP BY
   art_id
   , sm_id
   , mandant_id
   ) AS lsl
   INNER JOIN dbp_view.v_l_sternchen_1 AS ls
   ON  lsl.list_durchg_fg = ls.list_durchg_fg
   AND lsl.bezugsweg1_fg  = ls.bezugsweg1_fg
   AND lsl.bezugsweg4_fg  = ls.bezugsweg4_fg
   AND lsl.kdis0_fg       = ls.kdis0_fg
   AND lsl.kdis1_fg       = ls.kdis1_fg
   AND lsl.mandant_id     = ls.mandant_id
   ) AS sk
   GROUP BY 1, 2;