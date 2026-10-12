CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_REGION_SPR_ZU(
	LAND_ID,
	REGION_ID,
	SAP_REGION_ID,
	REGION_NAME,
	REGION_NAME_DE,
	REGION_NAME_CZ,
	REGION_NAME_SK,
	REGION_NAME_HR,
	REGION_NAME_PL,
	REGION_NAME_RO,
	REGION_NAME_BG
) AS
   SELECT
   v01.land_id
   ,v01.region_id
   ,v01.sap_region_id
   ,COALESCE(MAX(CASE WHEN v01.mandant_id = 1 THEN v01.region_name END),'N/A') AS region_name
   ,COALESCE(MAX(CASE WHEN v01.mandant_id = 1 THEN v01.region_name END),'N/A') AS region_name_de
   ,COALESCE(MAX(CASE WHEN v01.mandant_id = 2 THEN v01.region_name END), region_name_de) AS region_name_cz
   ,COALESCE(MAX(CASE WHEN v01.mandant_id = 5 THEN v01.region_name END), region_name_de) AS region_name_sk   
   ,COALESCE(MAX(CASE WHEN v01.mandant_id = 6 THEN v01.region_name END), region_name_de) AS region_name_hr   
   ,COALESCE(MAX(CASE WHEN v01.mandant_id = 3 THEN v01.region_name END), region_name_de) AS region_name_pl
   ,COALESCE(MAX(CASE WHEN v01.mandant_id = 7 THEN v01.region_name END), region_name_de) AS region_name_ro
   ,COALESCE(MAX(CASE WHEN v01.mandant_id = 8 THEN v01.region_name END), region_name_de) AS region_name_bg
 FROM dbp_view.v_region v01
 GROUP BY
 v01.land_id
,v01.region_id
,v01.sap_region_id;