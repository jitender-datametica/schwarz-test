CREATE OR REPLACE VIEW dbp_msi_view_ais_kmo.mv_akt_gp_2
--02.02.2021 lsvi0303 AP0039308, SPEC0091145 - DE Bezeichnung für BG Lieferanten
--INC4343362 Wegfall Join auf akt_msi_user_spr_zu_2, keine Mehrsprachigkeit - sschuecke 03.03.2022
(
 mandant_id
,akt_gp_id
,akt_gp_name
)
AS
SELECT
 v01.mandant_id
,v01.gp_id AS akt_gp_id
,v01.gp_name AS akt_gp_name
FROM dbp_view.v_gp_2 v01
WHERE v01.mandant_id <> 1;