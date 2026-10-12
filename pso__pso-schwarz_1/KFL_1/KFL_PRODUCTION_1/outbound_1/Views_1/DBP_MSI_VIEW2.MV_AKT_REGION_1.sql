CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_akt_region_1 (akt_region_id, sap_region_id, land_id, region_name,
mandant_id) AS SELECT region_id AS akt_region_id,
 sap_region_id,
 land_id,
 region_name,
 mandant_id
FROM kfl_production_dbp_view.v_region_1
WHERE mandant_id = 1
 AND land_id = 'DE';