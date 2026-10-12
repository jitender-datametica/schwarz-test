CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_ikpf_2 (mandant_id, inv_beleg_id, gj, zaehl_status_id,
diff_ausb_status_id, dat_letzt_zaehl) AS SELECT mandant_id,
 inv_beleg_id,
 gj,
 zaehl_status_id,
 diff_ausb_status_id,
 dat_letzt_zaehl
FROM kfl_production_dbp_view.v_inventur_2 AS V01;