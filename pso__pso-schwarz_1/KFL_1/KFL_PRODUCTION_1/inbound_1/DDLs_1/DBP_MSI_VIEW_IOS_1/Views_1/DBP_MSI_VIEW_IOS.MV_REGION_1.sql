CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_REGION_1
(
land_id
,region_id
,mandant_id
,sap_region_id
,region_name
)
AS
   SELECT
  land_id, region_id, mandant_id, sap_region_id, region_name
   FROM dbp_view.v_region_1;