CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_gehalts_region_spr_zu_cz_2 (mandant_id, gehalts_region_id,
spr_id, gehalts_region_bez) AS SELECT mandant_id,
 gehalts_region_id,
 spr_id,
 gehalts_region_bez
FROM kfl_production_dbp_view.v_gehalts_region_spr_zu_2 AS V01
WHERE spr_id = 124;