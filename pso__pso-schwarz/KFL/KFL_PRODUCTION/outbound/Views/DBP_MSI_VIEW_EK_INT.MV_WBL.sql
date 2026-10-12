CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_wbl (mandant_id, wbl_id, wbl_dat_von, wbl_name) AS SELECT
 mandant_id,
 wbl_id,
 wbl_dat_von,
 wbl_name
FROM kfl_production_dbp_view.v_wbl;