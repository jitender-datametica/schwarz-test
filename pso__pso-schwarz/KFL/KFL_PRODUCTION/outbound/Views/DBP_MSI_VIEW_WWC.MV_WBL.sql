CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_wbl (mandant_id, ek_flg, gf_id, ek_gf_id, wbl_dat_von, wbl_id
, wbl_name) AS SELECT mandant_id,
 ek_fg AS ek_flg,
 gf_id,
 gf_id AS ek_gf_id,
 wbl_dat_von,
 wbl_id,
 wbl_name
FROM kfl_production_dbp_view.v_wbl
WHERE mandant_id = 1;