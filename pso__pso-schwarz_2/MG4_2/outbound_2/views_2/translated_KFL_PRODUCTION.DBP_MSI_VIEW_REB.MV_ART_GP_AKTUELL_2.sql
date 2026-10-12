CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_art_gp_aktuell_2 (mandant_id, art_id, akt_gp_id) AS SELECT
 mandant_id,
 art_id,
 gp_id AS akt_gp_id
FROM kfl_production_dbp_view.v_art_gp_zu_per_2
WHERE dat_bis = DATE '9999-12-31';