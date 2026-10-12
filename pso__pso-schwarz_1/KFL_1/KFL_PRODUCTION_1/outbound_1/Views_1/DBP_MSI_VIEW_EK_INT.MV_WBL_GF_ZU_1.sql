CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_wbl_gf_zu_1 (mandant_id, wbl_id, gf_id) AS SELECT mandant_id
 ,
 wbl_id,
 gf_id
FROM kfl_production_dbp_security.wbl_gf_zu_1;