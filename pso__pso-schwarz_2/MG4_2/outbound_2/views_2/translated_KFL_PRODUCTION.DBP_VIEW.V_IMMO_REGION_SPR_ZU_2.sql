CREATE OR REPLACE VIEW kfl_production_dbp_view.v_immo_region_spr_zu_2 (mandant_id, region_id, spr_id, region_bez) AS
SELECT mandant_id,
 region_id,
 spr_id,
 region_bez
FROM kfl_production_dbp_data.immo_region_spr_zu_2;