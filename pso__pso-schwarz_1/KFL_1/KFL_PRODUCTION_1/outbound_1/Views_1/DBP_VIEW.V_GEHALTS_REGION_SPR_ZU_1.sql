CREATE OR REPLACE VIEW kfl_production_dbp_view.v_gehalts_region_spr_zu_1 AS SELECT mandant_id,
 gehalts_region_id,
 spr_id,
 gehalts_region_bez
FROM kfl_production_dbp_data.gehalts_region_spr_zu_1;