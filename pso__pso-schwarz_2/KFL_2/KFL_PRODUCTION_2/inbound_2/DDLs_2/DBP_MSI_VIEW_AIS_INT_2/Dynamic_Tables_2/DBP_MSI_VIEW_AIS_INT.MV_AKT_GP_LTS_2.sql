CREATE OR REPLACE DYNAMIC TABLE dbp_msi_view_ais_int.mv_akt_gp_lts_2
--02.02.2021 lsvi0303 AP0039308, SPEC0091145 - DE Bezeichnung für BG Lieferanten
(
  mandant_id
, akt_gp_id
, akt_gp_name
, akt_gp_name_de
, akt_gp_name_cz
, akt_gp_name_pl
, akt_gp_name_md
, akt_gp_name_sk
, akt_gp_name_hr
, akt_gp_name_ro
, akt_gp_name_bg
, gp_teilsortiment_id
, gp_teilsortiment_bez
, gp_teilsortiment_bez_de
, gp_teilsortiment_bez_cz
, gp_teilsortiment_bez_sk
, gp_teilsortiment_bez_hr
, gp_teilsortiment_bez_pl
, gp_teilsortiment_bez_ro
, gp_teilsortiment_bez_bg
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
SELECT
v01.mandant_id,
v01.gp_id,
v03.gp_name_lat AS akt_gp_name,
v03.gp_name_lat AS akt_gp_name_de -- DE
,
v03.gp_name_lat AS akt_gp_name_cz  -- CZ
,
v03.gp_name_lat AS akt_gp_name_pl -- PL
,
v03.gp_name_lat AS akt_gp_name_md    -- MD
,
v03.gp_name_lat AS akt_gp_name_sk    -- SK
,
v03.gp_name_lat AS akt_gp_name_hr    -- HR
,
v03.gp_name_lat AS akt_gp_name_ro   -- RO
,
v03.gp_name AS akt_gp_name_bg  -- BG
,
v01.gp_teilsortiment_id,
Coalesce(Max(CASE
WHEN v02.spr_id =  22 THEN v02.gp_teilsortiment_bez END),'N/A') AS gp_teilsortiment_bez                                                             -- Standard == DE
,
Coalesce(Max(CASE
WHEN v02.spr_id =  22 THEN v02.gp_teilsortiment_bez END),'N/A') AS gp_teilsortiment_bez_de                                                     -- DE
,
Coalesce(Max(CASE
WHEN v02.spr_id = 124 THEN v02.gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_cz  -- CZ
,
Coalesce(Max(CASE
WHEN v02.spr_id = 108 THEN v02.gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_sk -- SK
,
Coalesce(Max(CASE
WHEN v02.spr_id =  65 THEN v02.gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_hr    -- HR
,
Coalesce(Max(CASE
WHEN v02.spr_id =  90 THEN v02.gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_pl    -- PL
,
Coalesce(Max(CASE
WHEN v02.spr_id =  95 THEN v02.gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_ro   -- RO
,
Coalesce(Max(CASE
WHEN v02.spr_id =  18 THEN v02.gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_bg  -- BG

FROM dbp_view.v_l_gp_teilsortiment_2 v01

JOIN dbp_view.v_gp_teilsortiment_spr_zu_2 v02
ON v01.mandant_id = v02.mandant_id
AND v01.gp_id = v02.gp_id
AND v01.gp_teilsortiment_id = v02.gp_teilsortiment_id

JOIN dbp_view.v_gp_2 v03
ON v01.mandant_id = v03.mandant_id
AND v01.gp_id = v03.gp_id

WHERE v01.gp_id <> -1
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12

UNION ALL
SELECT
v01.mandant_id,
v03.gp_id,
v03.gp_name_lat AS akt_gp_name,
v03.gp_name_lat AS akt_gp_name_de -- DE
,
v03.gp_name_lat AS akt_gp_name_cz  -- CZ
,
v03.gp_name_lat AS akt_gp_name_pl -- PL
,
v03.gp_name_lat AS akt_gp_name_md    -- MD
,
v03.gp_name_lat AS akt_gp_name_sk    -- SK
,
v03.gp_name_lat AS akt_gp_name_hr    -- HR
,
v03.gp_name_lat AS akt_gp_name_ro   -- RO
,
v03.gp_name AS akt_gp_name_bg  -- BG
,
v01.gp_teilsortiment_id,
Coalesce(Max(CASE
WHEN v02.spr_id =  22 THEN v02.gp_teilsortiment_bez END),'N/A') AS gp_teilsortiment_bez                                                             -- Standard == DE
,
Coalesce(Max(CASE
WHEN v02.spr_id =  22 THEN v02.gp_teilsortiment_bez END),'N/A') AS gp_teilsortiment_bez_de                                                     -- DE
,
Coalesce(Max(CASE
WHEN v02.spr_id = 124 THEN v02.gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_cz  -- CZ
,
Coalesce(Max(CASE
WHEN v02.spr_id = 108 THEN v02.gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_sk -- SK
,
Coalesce(Max(CASE
WHEN v02.spr_id =  65 THEN v02.gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_hr    -- HR
,
Coalesce(Max(CASE
WHEN v02.spr_id =  90 THEN v02.gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_pl    -- PL
,
Coalesce(Max(CASE
WHEN v02.spr_id =  95 THEN v02.gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_ro   -- RO
,
Coalesce(Max(CASE
WHEN v02.spr_id =  18 THEN v02.gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_bg  -- BG

FROM dbp_view.v_l_gp_teilsortiment_2 v01

JOIN dbp_view.v_gp_teilsortiment_spr_zu_2 v02
ON v01.mandant_id = v02.mandant_id
AND v01.gp_id = v02.gp_id
AND v01.gp_teilsortiment_id = v02.gp_teilsortiment_id

JOIN dbp_view.v_gp_2 v03
ON v01.mandant_id = v03.mandant_id

WHERE v01.gp_id = -1
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12;