CREATE OR REPLACE VIEW kfl_production_dbp_view.v_region_1 (land_id, region_id, mandant_id, sap_region_id, region_name,
td_insert, td_update) AS SELECT land_id,
 region_id,
 mandant_id,
 sap_region_id,
 region_name,
 td_insert,
 td_update
FROM kfl_production_dbp_data.region_1;