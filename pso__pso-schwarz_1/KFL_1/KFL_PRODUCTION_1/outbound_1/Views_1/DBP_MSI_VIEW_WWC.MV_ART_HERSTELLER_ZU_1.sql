CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_art_hersteller_zu_1 (mandant_id, art_id, herst_id, gp_art_id,
mhd_zeitraum_dz) AS SELECT mandant_id,
 art_id,
 herst_id,
 gp_art_id,
 mhd_zeitraum_dz
FROM kfl_production_dbp_view.v_art_gp_zu_per_1
WHERE dat_bis = DATE '9999-12-31';