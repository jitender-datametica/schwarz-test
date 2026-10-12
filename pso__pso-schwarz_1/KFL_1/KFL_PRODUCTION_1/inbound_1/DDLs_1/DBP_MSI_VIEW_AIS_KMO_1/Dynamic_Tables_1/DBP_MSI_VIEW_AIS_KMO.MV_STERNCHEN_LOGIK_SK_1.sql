CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_STERNCHEN_LOGIK_SK_1
-- SPEC0066356 Erweiterung um Felder ks1_id - ks7_id / sschuecke 03.12.2019
(
  mandant_id
, art_id
, list_durchg_fg
, sx_id
, s1_id
, s2_id
, s3_id
, s4_id
, s5_id
, ks1_id
, ks2_id
, ks3_id
, ks4_id
, ks5_id
, ks6_id
, ks7_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS

   SELECT v03.mandant_id,
   v03.art_id,
   Max(v03.list_durchg_fg),
   Max(v03.sx_id),
   Max(v03.s1_id),
   Max(v03.s2_id),
   Max(v03.s3_id),
   Max(v03.s4_id),
   Max(v03.s5_id),
   Max(v03.ks1_id),
   Max(v03.ks2_id),
   Max(v03.ks3_id),
   Max(v03.ks4_id),
   Max(v03.ks5_id),
   Max(v03.ks6_id),
   Max(v03.ks7_id)

  FROM (

  SELECT v01.mandant_id,
   v01.art_id,
   v01.list_durchg_fg,
   Cast (CASE v01.sm_id WHEN -1 THEN v02.sternchen_id ELSE '  ' END AS CHAR(2)) sx_id,
   Cast (CASE v01.sm_id WHEN 1 THEN v02.sternchen_id ELSE '  ' END AS CHAR(2)) s1_id,
   Cast (CASE v01.sm_id WHEN 2 THEN v02.sternchen_id ELSE '  ' END AS CHAR(2)) s2_id,
   Cast (CASE v01.sm_id WHEN 3 THEN v02.sternchen_id ELSE '  ' END AS CHAR(2)) s3_id,
   Cast (CASE v01.sm_id WHEN 4 THEN v02.sternchen_id ELSE '  ' END AS CHAR(2)) s4_id,
   Cast (CASE v01.sm_id WHEN 5 THEN v02.sternchen_id ELSE '  ' END AS CHAR(2)) s5_id,
   Cast (CASE v01.ksm_id WHEN 'K1' THEN v02.sternchen_id ELSE '  ' END AS CHAR(2)) ks1_id,
   Cast (CASE v01.ksm_id WHEN 'K2' THEN v02.sternchen_id ELSE '  ' END AS CHAR(2)) ks2_id,
   Cast (CASE v01.ksm_id WHEN 'K3' THEN v02.sternchen_id ELSE '  ' END AS CHAR(2)) ks3_id,
   Cast (CASE v01.ksm_id WHEN 'K4' THEN v02.sternchen_id ELSE '  ' END AS CHAR(2)) ks4_id,
   Cast (CASE v01.ksm_id WHEN 'K5' THEN v02.sternchen_id ELSE '  ' END AS CHAR(2)) ks5_id,
   Cast (CASE v01.ksm_id WHEN 'K6' THEN v02.sternchen_id ELSE '  ' END AS CHAR(2)) ks6_id,
   Cast (CASE v01.ksm_id WHEN 'K7' THEN v02.sternchen_id ELSE '  ' END AS CHAR(2)) ks7_id

  FROM dbp_view.v_sternchen_logik_1 v01
   JOIN dbp_view.v_l_sternchen_1 v02
   ON v01.list_durchg_fg = v02.list_durchg_fg
   AND v01.bezugsweg1_fg = v02.bezugsweg1_fg
   AND v01.bezugsweg4_fg = v02.bezugsweg4_fg
   AND v01.kdis0_fg = v02.kdis0_fg
   AND v01.kdis1_fg = v02.kdis1_fg
   AND v01.mandant_id = v02.mandant_id

   WHERE v01.mandant_id <> 1) v03

   GROUP BY 1, 2;