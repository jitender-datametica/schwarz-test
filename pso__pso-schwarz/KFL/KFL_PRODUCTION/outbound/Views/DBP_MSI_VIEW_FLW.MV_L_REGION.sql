CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_region (region_id, sap_region_id, land_id, region_name,
mandant_id) AS SELECT region_id,
 sap_region_id,
 land_id,
 region_name,
 mandant_id
FROM kfl_production_dbp_view.v_region
WHERE mandant_id = 1 AND land_id = 'DE'
 OR mandant_id = 2 AND land_id = 'CZ';