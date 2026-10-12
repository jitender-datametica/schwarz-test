CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_region_spr_zu_pl (region_id, sap_region_id, land_id,
region_name, mandant_id) AS SELECT region_id,
 sap_region_id,
 land_id,
 region_name,
 mandant_id
FROM kfl_production_dbp_view.v_region AS V01
WHERE mandant_id = 3;