CREATE OR REPLACE DYNAMIC TABLE dbp_msi_view_ais_int.mv_info_gp_lts_2
--02.02.2021 lsvi0303 AP0039308, SPEC0091145 - DE Bezeichnung für BG Lieferanten
(
  mandant_id
, gp_id
, gp_name
, gp_name_de
, gp_name_cz
, gp_name_pl
, gp_name_md
, gp_name_sk
, gp_name_hr
, gp_name_ro
, gp_name_bg
, gp_teilsortiment_id
, gp_teilsortiment_bez
, zek_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
SELECT
v01.mandant_id,
v01.gp_id,
v03.gp_name_lat AS gp_name,
v03.gp_name_lat AS gp_name_de -- DE
,
v03.gp_name_lat AS gp_name_cz  -- CZ
,
v03.gp_name_lat AS gp_name_pl -- PL
,
v03.gp_name_lat AS gp_name_md    -- MD
,
v03.gp_name_lat AS gp_name_sk    -- SK
,
v03.gp_name_lat AS gp_name_hr    -- HR
,
v03.gp_name_lat AS gp_name_ro   -- RO
,
v03.gp_name AS gp_name_bg  -- BG
,
v01.gp_teilsortiment_id,
v02.gp_teilsortiment_bez,
v01.zek_id

FROM dbp_view.v_l_gp_teilsortiment_2 v01

JOIN dbp_view.v_gp_teilsortiment_spr_zu_2 v02
ON v01.mandant_id = v02.mandant_id
AND v01.gp_id = v02.gp_id
AND v01.gp_teilsortiment_id = v02.gp_teilsortiment_id

JOIN dbp_view.v_gp_2 v03
ON v01.mandant_id = v03.mandant_id
AND v01.gp_id = v03.gp_id

WHERE v01.gp_id <> -1

UNION ALL
SELECT
v01.mandant_id,
v03.gp_id,
v03.gp_name_lat AS gp_name,
v03.gp_name_lat AS gp_name_de -- DE
,
v03.gp_name_lat AS gp_name_cz  -- CZ
,
v03.gp_name_lat AS gp_name_pl -- PL
,
v03.gp_name_lat AS gp_name_md    -- MD
,
v03.gp_name_lat AS gp_name_sk    -- SK
,
v03.gp_name_lat AS gp_name_hr    -- HR
,
v03.gp_name_lat AS gp_name_ro   -- RO
,
v03.gp_name AS gp_name_bg  -- BG
,
v01.gp_teilsortiment_id,
v02.gp_teilsortiment_bez,
v01.zek_id

FROM dbp_view.v_l_gp_teilsortiment_2 v01

JOIN dbp_view.v_gp_teilsortiment_spr_zu_2 v02
ON v01.mandant_id = v02.mandant_id
AND v01.gp_id = v02.gp_id
AND v01.gp_teilsortiment_id = v02.gp_teilsortiment_id

JOIN dbp_view.v_gp_2 v03
ON v01.mandant_id = v03.mandant_id

WHERE v01.gp_id = -1;