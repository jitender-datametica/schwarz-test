CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_region_2 (region_id, sap_region_id, land_id, region_name,
mandant_id, system_id) AS SELECT region_id,
 sap_region_id,
 land_id,
 region_name,
 mandant_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_region_2
WHERE mandant_id = 1;