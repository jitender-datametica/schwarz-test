CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_region (land_id, region_id, mandant_id, sap_region_id,
region_name, td_insert, td_update) AS SELECT land_id,
 region_id,
 mandant_id,
 sap_region_id,
 region_name,
 td_insert,
 td_update
FROM kfl_production_dbp_data.region;