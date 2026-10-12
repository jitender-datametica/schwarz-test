CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_wbl_2 (wbl_id, mandant_id, wbl_dat_von, wbl_name, gf_id, ek_fg,
system_id) AS SELECT wbl_id,
 mandant_id,
 wbl_dat_von,
 wbl_name,
 gf_id,
 ek_fg,
 7 AS system_id
FROM kfl_production_dbp_view.v_wbl_2
WHERE mandant_id = 1;