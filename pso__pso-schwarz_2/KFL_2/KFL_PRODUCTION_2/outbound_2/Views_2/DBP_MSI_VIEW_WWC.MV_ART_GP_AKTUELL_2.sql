CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_art_gp_aktuell_2 (art_id, akt_gp_id, mandant_id) AS SELECT
 art_id,
 gp_id AS akt_gp_id,
 mandant_id
FROM kfl_production_dbp_view.v_art_gp_zu_per_2 AS V01
WHERE mandant_id = 1
 AND dat_bis = DATE '9999-12-31';