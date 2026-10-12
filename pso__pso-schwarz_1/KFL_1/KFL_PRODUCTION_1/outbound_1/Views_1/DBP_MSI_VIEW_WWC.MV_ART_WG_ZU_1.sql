CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_art_wg_zu_1 (art_id, mandant_id, prdha, wug_id, matkl, wg_id) AS
SELECT art_id,
 mandant_id,
 wug_id AS prdha,
 wug_id,
 wg_id AS matkl,
 wg_id
FROM kfl_production_dbp_view.v_art_wg_zu_per_1
WHERE arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31';