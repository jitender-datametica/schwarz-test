CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_REGION_SPR_ZU
AS
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