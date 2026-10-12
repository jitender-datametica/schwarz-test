CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_INFO_GP_1
--02.02.2021 lsvi0303 AP0039308, SPEC0091145 - DE Bezeichnung für BG Lieferanten
--AP0114176/SPEC0139840 Entfall Join AKT_MSI_USER_SPR_ZU_1, da nur im Feld GP_NAME Daten / ssch1303 02.02.2022
(
 mandant_id
,gp_id
,gp_name
,zek_id
)

AS
SELECT
 v01.mandant_id
,v01.gp_id
,v01.gp_name
,v01.zek_id

FROM dbp_view.v_gp_1 v01
WHERE v01.mandant_id <> 1;