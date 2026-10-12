CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_l_gehalts_region_1 (mandant_id, gehalts_region_id) AS SELECT
 mandant_id,
 gehalts_region_id
FROM kfl_production_dbp_view.v_l_gehalts_region_1 AS V01;