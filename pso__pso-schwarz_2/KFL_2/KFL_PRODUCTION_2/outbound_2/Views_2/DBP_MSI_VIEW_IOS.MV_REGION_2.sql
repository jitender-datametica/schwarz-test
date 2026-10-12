CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_region_2 (land_id, region_id, mandant_id, sap_region_id,
region_name) AS SELECT land_id,
 region_id,
 mandant_id,
 sap_region_id,
 region_name
FROM kfl_production_dbp_view.v_region_2;