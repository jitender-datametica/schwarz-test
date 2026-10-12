CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_art_gp_aktuell AS SELECT mandant_id,
 art_id,
 gp_id,
 einkaufsorganisation_id,
 gp_art_id,
 herst_id,
 mhd_zeitraum_dz,
 mutter_ek_id
FROM kfl_production_dbp_view.v_art_gp_zu_per
WHERE dat_bis = DATE '9999-12-31';