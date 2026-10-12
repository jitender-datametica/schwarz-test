CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_art_mutter_bezugsweg_wup_1 AS SELECT mandant_id,
 wup_id,
 art_id AS art_mutter_wb_id,
 bezugsweg_id AS art_mutter_bezugsweg_id
FROM kfl_production_dbp_view.v_art_wup_status_per_1
WHERE dat_bis = DATE '9999-12-31'
 AND nb_id = 0;