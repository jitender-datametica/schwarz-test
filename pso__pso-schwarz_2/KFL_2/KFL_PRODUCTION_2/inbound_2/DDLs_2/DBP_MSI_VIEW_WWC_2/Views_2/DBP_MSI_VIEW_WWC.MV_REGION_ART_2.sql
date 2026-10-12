CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_REGION_ART_2
-- 24.08.2020, AP0033327, SPEC0067448, srom0404, Neuanlage
(
 region_id
,sap_region_id
,land_id
,region_name
,mandant_id
) 
AS 
SELECT 
 v01.region_id
,v01.sap_region_id
,v01.land_id
,v01.region_name
,v01.mandant_id 
FROM  DBP_VIEW.v_region_2 v01
WHERE mandant_id = 1;