CREATE OR REPLACE VIEW dbp_msi_view_ais_int.mv_gp_spr_zu_2
(
  gp_id
, mandant_id
, gp_name
, gp_name_de
, gp_name_cz
, gp_name_pl
, gp_name_md
, gp_name_sk
, gp_name_hr
, gp_name_ro
, gp_name_bg
)
AS
SELECT
v01.gp_id,
v01.mandant_id,
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

FROM dbp_view.v_gp_2 v01, dbp_view.v_region_2 v02

WHERE v01.mandant_id = v02.mandant_id
AND v01.land_id = v02.land_id
AND v01.region_id = v02.region_id
AND v01.gp_id NOT BETWEEN 10000 AND 999999;
