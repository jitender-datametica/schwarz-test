CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku_materialized.mv_l_art_1 (art_id, mandant_id, kl_art_id) AS SELECT
 art_id,
 mandant_id,
 kl_art_id
FROM kfl_production_dbp_view.v_art_1;