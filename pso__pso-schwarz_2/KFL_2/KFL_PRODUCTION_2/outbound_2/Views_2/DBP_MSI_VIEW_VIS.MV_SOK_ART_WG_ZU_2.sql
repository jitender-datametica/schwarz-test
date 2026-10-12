CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sok_art_wg_zu_2 (mandant_id, art_id, sok_wg_id) AS SELECT
 mandant_id,
 art_id,
 wg_id AS sok_wg_id
FROM kfl_production_dbp_view.v_art_wg_zu_per_2 AS V01
WHERE arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31';