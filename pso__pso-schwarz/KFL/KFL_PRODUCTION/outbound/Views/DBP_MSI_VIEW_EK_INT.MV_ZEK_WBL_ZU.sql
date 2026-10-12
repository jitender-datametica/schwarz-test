CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_zek_wbl_zu (mandant_id, zek_id, wbl_id) AS SELECT
 mandant_id,
 zek_id,
 wbl_id
FROM kfl_production_dbp_security.zek_wbl_zu;