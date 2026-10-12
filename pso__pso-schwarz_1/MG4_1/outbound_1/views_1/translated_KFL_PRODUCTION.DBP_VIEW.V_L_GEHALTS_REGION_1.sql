CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_gehalts_region_1 (mandant_id, gehalts_region_id) AS SELECT mandant_id,
 gehalts_region_id
FROM kfl_production_dbp_data.l_gehalts_region_1;