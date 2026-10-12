CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_l_miet_region_2 AS SELECT mandant_id,
 miet_region_id,
 miet_region_bez,
 bl_id,
 bl_bez,
 spr_id
FROM kfl_production_dbp_view.v_ivs_l_miet_region_2
WHERE spr_id = 22;