CREATE OR REPLACE DYNAMIC TABLE dbp_msi_view_ais_int.mv_info_gp_1
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
, zek_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
SELECT
v01.mandant_id,
v01.gp_id,
v01.gp_name_lat AS gp_name,
v01.gp_name_lat AS gp_name_de -- DE
,
v01.gp_name_lat AS gp_name_cz  -- CZ
,
v01.gp_name_lat AS gp_name_pl -- PL
,
v01.gp_name_lat AS gp_name_md    -- MD
,
v01.gp_name_lat AS gp_name_sk    -- SK
,
v01.gp_name_lat AS gp_name_hr    -- HR
,
v01.gp_name_lat AS gp_name_ro   -- RO
,
v01.gp_name AS gp_name_bg  -- BG
,
v01.zek_id

FROM dbp_view.v_gp_1 v01;