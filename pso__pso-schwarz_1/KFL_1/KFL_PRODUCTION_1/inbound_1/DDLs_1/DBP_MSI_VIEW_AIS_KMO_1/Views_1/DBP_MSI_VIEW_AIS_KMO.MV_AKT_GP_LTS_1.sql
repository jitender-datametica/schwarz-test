CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_AKT_GP_LTS_1
--02.02.2021 lsvi0303 AP0039308, SPEC0091145 - DE Bezeichnung für BG Lieferanten
--AP0114176/SPEC0139840 Entfall Join AKT_MSI_USER_SPR_ZU_1, da nur im Feld GP_NAME Daten / ssch1303 02.02.2022
(
 mandant_id
,akt_gp_id
,akt_gp_name
,gp_teilsortiment_id
,gp_teilsortiment_bez
)

AS
SELECT
 v01.mandant_id
,v01.gp_id
,v03.gp_name
,v01.gp_teilsortiment_id
,v02.gp_teilsortiment_bez
		   	
FROM dbp_view.v_l_gp_teilsortiment_1 v01

JOIN dbp_view.v_gp_teilsortiment_spr_zu_1 v02
ON v01.mandant_id = v02.mandant_id
AND v01.gp_id = v02.gp_id
AND v01.gp_teilsortiment_id = v02.gp_teilsortiment_id

JOIN dbp_view.v_gp_1 v03
ON v01.mandant_id = v03.mandant_id
AND v01.gp_id = v03.gp_id

WHERE v01.mandant_id <> 1
AND v01.gp_id <> -1

UNION ALL
SELECT
 v01.mandant_id
,v03.gp_id
,v03.gp_name
,v01.gp_teilsortiment_id
,v02.gp_teilsortiment_bez
		   			
FROM dbp_view.v_l_gp_teilsortiment_1 v01

JOIN dbp_view.v_gp_teilsortiment_spr_zu_1 v02
ON v01.mandant_id = v02.mandant_id
AND v01.gp_id = v02.gp_id
AND v01.gp_teilsortiment_id = v02.gp_teilsortiment_id

JOIN dbp_view.v_gp_1 v03
ON v01.mandant_id = v03.mandant_id

WHERE v01.mandant_id <> 1
AND v01.gp_id = -1;