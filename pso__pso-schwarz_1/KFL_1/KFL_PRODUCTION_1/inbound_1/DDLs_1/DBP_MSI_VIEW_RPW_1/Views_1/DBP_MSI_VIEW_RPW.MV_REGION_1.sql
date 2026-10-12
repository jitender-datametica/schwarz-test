CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_REGION_1
(
  region_id
  ,sap_region_id
  ,land_id
  ,region_name
  ,mandant_id
  ,system_id
)
AS
   SELECT
     region_id,
   sap_region_id,
   land_id,
   region_name,
   mandant_id,
   7 AS system_id
   FROM dbp_view.v_region_1
   WHERE mandant_id = 1
 ;