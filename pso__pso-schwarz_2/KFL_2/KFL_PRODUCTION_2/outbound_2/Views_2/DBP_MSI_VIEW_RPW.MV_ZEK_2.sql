CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_zek_2 (mandant_id, zek_id, wbl_id, zek_name, zek_abt_bez,
system_id) AS SELECT mandant_id,
 zek_id,
 wbl_id,
 zek_name,
 zek_abt_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_zek_2
WHERE mandant_id = 1;