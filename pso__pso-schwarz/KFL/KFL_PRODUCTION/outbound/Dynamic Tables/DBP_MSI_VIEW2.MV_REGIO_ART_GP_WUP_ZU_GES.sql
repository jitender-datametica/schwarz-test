CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_regio_art_gp_wup_zu_ges
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  regio_stufe_id AS regio_stufe_id,
  gp_id AS gp_id,
  art_id AS art_id,
  wup_id AS wup_id,
  nb_id AS nb_id,
  regio_polygon_id AS regio_polygon_id,
  MAX(CASE WHEN regio_stufe_id = 30 THEN regio_polygon_id ELSE NULL END) AS land_id,
  MAX(CASE WHEN regio_stufe_id = 20 THEN regio_polygon_id ELSE NULL END) AS bundesland_id,
  MAX(CASE WHEN regio_stufe_id = 10 THEN regio_polygon_id ELSE NULL END) AS gemeinde_id,
  MAX(CASE WHEN regio_stufe_id = 40 THEN regio_polygon_id ELSE NULL END) AS umland_id,
  MAX(CASE WHEN regio_stufe_id = 50 THEN regio_polygon_id ELSE NULL END) AS naturpark_id,
  MAX(CASE WHEN regio_stufe_id = 60 THEN regio_polygon_id ELSE NULL END) AS naturraum_id,
  MAX(CASE WHEN regio_stufe_id = 70 THEN regio_polygon_id ELSE NULL END) AS dummy_id,
  MAX(CASE WHEN regio_stufe_id = 80 THEN regio_polygon_id ELSE NULL END) AS dummy2_id
FROM kfl_production_dbp_view.v_regio_art_gp_wup_zu
WHERE
  mandant_id = 1 AND loesch_fg = 0
GROUP BY
  mandant_id,
  regio_stufe_id,
  art_id,
  gp_id,
  wup_id,
  nb_id,
  regio_polygon_id;
