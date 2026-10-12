CREATE OR REPLACE VIEW kfl_production_dbp_view.v_regio_polygon_art_gp_zu_2 AS SELECT mandant_id,
 regio_stufe_id,
 regio_polygon_id,
 art_id,
 gp_id,
 genehmigt_fg,
 td_update,
 td_insert
FROM kfl_production_dbp_data.regio_polygon_art_gp_zu_2;