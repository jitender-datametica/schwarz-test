CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ivs_l_miet_region AS SELECT miet_region_id,
 mandant_id,
 bl_id,
 spr_id,
 miet_region_bez,
 bl_bez
FROM kfl_production_dbp_data.ivs_l_miet_region;