CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_regio_polygon_art_gp_zu_1 (mandant_id, regio_stufe_id,
regio_polygon_id, art_id, gp_id, genehmigt_fg) AS SELECT mandant_id,
 regio_stufe_id,
 regio_polygon_id,
 art_id,
 gp_id,
  CASE
  WHEN genehmigt_fg = 1
  THEN 'X'
  ELSE ' '
  END AS genehmigt_fg
FROM kfl_production_dbp_view.v_regio_polygon_art_gp_zu_1
WHERE mandant_id = 1;