CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_REGION_SPR_ZU_EN_1
(
region_id
,sap_region_id
,land_id
,region_name
,mandant_id
)
AS
   SELECT  v01.region_id, v01.sap_region_id, v01.land_id, v01.region_name, v01.mandant_id
   FROM dbp_view.v_region_1 v01
   WHERE v01.mandant_id = 1  -- Deutschland f??ngl. View
;