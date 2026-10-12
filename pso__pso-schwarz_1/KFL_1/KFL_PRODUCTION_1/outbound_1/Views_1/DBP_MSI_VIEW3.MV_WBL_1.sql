CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_wbl_1 (ek_flg, gf_id, wbl_dat_von, wbl_id, wbl_name, mandant_id) AS
SELECT ek_fg AS ek_flg,
 gf_id,
 wbl_dat_von,
 wbl_id,
 wbl_name,
 mandant_id
FROM kfl_production_dbp_view.v_wbl_1;