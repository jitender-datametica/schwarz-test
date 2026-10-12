CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_art_gp_zu_per_2 (art_id, gp_id, mandant_id,
herst_id, gp_art_id, dat_von, dat_bis) AS SELECT art_id,
 gp_id,
 mandant_id,
 herst_id,
 gp_art_id,
 dat_von,
 dat_bis
FROM kfl_production_dbp_view.v_art_gp_zu_per_2
WHERE dat_bis = DATE '9999-12-31';