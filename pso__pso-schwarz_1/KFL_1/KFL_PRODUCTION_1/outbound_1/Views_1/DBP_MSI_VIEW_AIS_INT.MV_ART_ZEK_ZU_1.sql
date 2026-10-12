CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_art_zek_zu_1 (art_id, mandant_id, zek_id) AS SELECT DISTINCT
 art_id,
 mandant_id,
 zek_id
FROM kfl_production_dbp_view.v_art_1
WHERE dat_bis = DATE '9999-12-31';