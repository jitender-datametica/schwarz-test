CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_art_wg_zu_1 AS SELECT mandant_id,
 arthiertyp_id,
 art_id,
 wug_id,
 wg_id,
 dat_von,
 dat_bis
FROM kfl_production_dbp_view.v_art_wg_zu_per_1 AS V01
WHERE arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31';