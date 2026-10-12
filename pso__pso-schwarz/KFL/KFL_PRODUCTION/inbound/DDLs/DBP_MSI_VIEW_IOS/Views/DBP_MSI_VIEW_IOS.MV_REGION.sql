CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_REGION
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
   FROM dbp_view.v_region;