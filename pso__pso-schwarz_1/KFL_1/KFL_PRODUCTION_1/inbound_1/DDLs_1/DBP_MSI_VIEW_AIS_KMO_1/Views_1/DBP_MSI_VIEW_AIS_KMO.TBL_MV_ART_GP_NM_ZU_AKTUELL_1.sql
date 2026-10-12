CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.TBL_MV_ART_GP_NM_ZU_AKTUELL_1
--02.02.2021 lsvi0303 AP0039308, SPEC0091145 - DE Bezeichnung für BG Lieferanten
(
 mandant_id
,art_id
,akt_gp_id
,gp_name
,spr_id
)
AS
SELECT
v01.mandant_id,
v01.art_id,
v01.gp_id,
v02.gp_name,
v02.spr_id
FROM dbp_view.v_art_gp_nm_zu_per_1 v01
JOIN (SELECT
v01.mandant_id,
v01.gp_id,
v02.spr_id,
CASE
WHEN spr_id = 18 THEN v01.gp_name
ELSE gp_name_lat END AS gp_name
FROM dbp_view.v_gp_1 v01

CROSS JOIN (SELECT DISTINCT spr_id
FROM dbp_view.v_mandant_spr_zu_1) v02) v02
ON v01.mandant_id = v02.mandant_id
AND v01.gp_id = v02.gp_id

WHERE v01.dat_bis = to_date('9999-12-31', 'YYYY-MM_1-DD')
    AND v01.gp_id <> -1
    AND v01.mandant_id <> 1
;