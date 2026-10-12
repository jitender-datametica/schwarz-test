CREATE OR REPLACE VIEW kfl_production_dbp_view.v_zek_2 (mandant_id, zek_id, wbl_id, zek_name, zek_abt_bez) AS SELECT
 mandant_id,
 zek_id,
 wbl_id,
 zek_name,
 zek_abt_bez
FROM kfl_production_dbp_data.zek_2;