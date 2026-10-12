CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_wbl_2 (ek_fg, gf_id, wbl_dat_von, wbl_id, wbl_name, mandant_id)
AS SELECT ek_fg,
 gf_id,
 wbl_dat_von,
 wbl_id,
 wbl_name,
 mandant_id
FROM kfl_production_dbp_view.v_wbl_2 AS V01;