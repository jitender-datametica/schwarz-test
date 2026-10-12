CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_REGION_ART_2(
	REGION_ID,
	SAP_REGION_ID,
	LAND_ID,
	REGION_NAME,
	MANDANT_ID
) AS 
--SPEC0298140, prescherad, 12.05.2025, Neuanlage 
SELECT 
 v01.region_id
,v01.sap_region_id
,v01.land_id
,v01.region_name
,v01.mandant_id 
FROM  DBP_VIEW.v_region_2 v01
WHERE mandant_id <> 1;