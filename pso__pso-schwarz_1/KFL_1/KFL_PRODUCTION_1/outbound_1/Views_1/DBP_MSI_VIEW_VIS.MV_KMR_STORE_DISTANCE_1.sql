CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kmr_store_distance_1 (mandant_id, system_name, nb_id, wup_id,
competitor_store_id, drivetime_distance_km) AS SELECT mandant_id,
 ext_system_name AS system_name,
 nb_id,
 wup_id,
 ext_store_id AS competitor_store_id,
 drivetime_distance_km
FROM kfl_production_dbp_view.v_retail_store_distance_1;