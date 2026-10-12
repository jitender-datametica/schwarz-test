CREATE OR REPLACE VIEW dbp_msi_view_ais_int.mv_akt_gp_spr_zu
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

)
AS
SELECT
v01.mandant_id,
v01.gp_id akt_gp_id,
v01.gp_name_lat AS akt_gp_name,
v01.gp_name_lat AS akt_gp_name_de -- DE
,
v01.gp_name_lat AS akt_gp_name_cz  -- CZ
,
v01.gp_name_lat AS akt_gp_name_pl -- PL
,
v01.gp_name_lat AS akt_gp_name_md    -- MD
,
v01.gp_name_lat AS akt_gp_name_sk    -- SK
,
v01.gp_name_lat AS akt_gp_name_hr    -- HR
,
v01.gp_name_lat AS akt_gp_name_ro   -- RO
,
v01.gp_name AS akt_gp_name_bg  -- BG

FROM dbp_view.v_gp v01;