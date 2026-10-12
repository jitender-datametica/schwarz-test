CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_wbl_1 (ek_fg, ek_gf_id, wbl_dat_von, wbl_id, wbl_name,
mandant_id) AS SELECT ek_fg,
 gf_id AS ek_gf_id,
 wbl_dat_von,
 wbl_id,
 wbl_name,
 mandant_id
FROM kfl_production_dbp_view.v_wbl_1;