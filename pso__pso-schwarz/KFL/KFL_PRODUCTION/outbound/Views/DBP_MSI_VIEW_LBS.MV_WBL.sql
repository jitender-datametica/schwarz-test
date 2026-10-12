CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_wbl (wbl_id, mandant_id, wbl_dat_von, wbl_name, gf_id, ek_fg)
AS SELECT wbl_id,
 mandant_id,
 wbl_dat_von,
 wbl_name,
 gf_id,
 ek_fg
FROM kfl_production_dbp_view.v_wbl;