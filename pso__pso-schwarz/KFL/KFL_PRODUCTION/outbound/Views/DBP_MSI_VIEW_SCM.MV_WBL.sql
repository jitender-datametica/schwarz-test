CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_wbl (ek_fg, gf_id, wbl_dat_von, wbl_id, wbl_name, mandant_id)
AS SELECT ek_fg,
 gf_id,
 wbl_dat_von,
 wbl_id,
 wbl_name,
 mandant_id
FROM kfl_production_dbp_view.v_wbl AS V01;