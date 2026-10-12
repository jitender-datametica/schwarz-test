CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_l_art_1 (art_id, mandant_id, kl_art_id) AS SELECT art_id,
 mandant_id,
 kl_art_id
FROM kfl_production_dbp_data.art_1;