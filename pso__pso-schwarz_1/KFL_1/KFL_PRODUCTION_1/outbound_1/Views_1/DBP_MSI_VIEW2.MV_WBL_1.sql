CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_wbl_1 (ek_flg, gf_id, wbl_dat_von, wbl_id, wbl_name, mandant_id) AS
SELECT ek_fg AS ek_flg,
 gf_id,
 wbl_dat_von,
 wbl_id,
 wbl_name,
 mandant_id
FROM kfl_production_dbp_view.v_wbl_1
WHERE mandant_id = 1
 AND wbl_dat_von >= DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY);