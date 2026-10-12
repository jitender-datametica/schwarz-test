CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_l_art (art_id, mandant_id, kl_art_id) AS SELECT art_id,
 mandant_id,
 kl_art_id
FROM kfl_production_dbp_view.v_art;