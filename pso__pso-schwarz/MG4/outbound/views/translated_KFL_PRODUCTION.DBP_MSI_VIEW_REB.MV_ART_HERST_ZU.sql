CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_art_herst_zu (mandant_id, art_id, herst_id, gp_art_id,
mhd_zeitraum_dz) AS SELECT mandant_id,
 art_id,
 herst_id,
 gp_art_id,
 mhd_zeitraum_dz
FROM kfl_production_dbp_view.v_art_gp_zu_per
WHERE mandant_id = 1
 AND dat_bis = DATE '9999-12-31';