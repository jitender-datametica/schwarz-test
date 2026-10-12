CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_ART_GP_NM_ZU_AKTUELL_2
--02.02.2021 lsvi0303 AP0039308, SPEC0091145 - DE Bezeichnung für BG Lieferanten
--INC4343362 Wegfall Join auf akt_msi_user_spr_zu_2, keine Mehrsprachigkeit - sschuecke 03.03.2022
(
 mandant_id
,art_id
,akt_gp_id
,gp_name
,anz_lief
)
AS
SELECT
 v01.mandant_id
,v01.art_id
,v01.gp_id AS akt_gp_id
,v02.gp_name
,COUNT(*) AS anz_lief

FROM dbp_view.v_art_gp_nm_zu_per_2 v01
JOIN dbp_view.v_gp_2 v02
ON v01.gp_id = v02.gp_id
AND v01.mandant_id = v02.mandant_id

WHERE v01.dat_bis = TO_DATE ('9999-12-31', 'YYYY-MM_2-DD')
AND v01.gp_id <> -1
AND v01.mandant_id <> 1

GROUP BY 
 v01.mandant_id
,v01.art_id
,v01.gp_id
,v02.gp_name
QUALIFY ROW_NUMBER() OVER (PARTITION BY v01.mandant_id, v01.art_id ORDER BY anz_lief DESC NULLS LAST) = 1;