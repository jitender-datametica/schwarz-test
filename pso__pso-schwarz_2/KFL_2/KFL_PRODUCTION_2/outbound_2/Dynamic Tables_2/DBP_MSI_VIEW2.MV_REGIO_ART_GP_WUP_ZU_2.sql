CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_regio_art_gp_wup_zu_2
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
  versendet_fg AS versendet_fg,
  loesch_fg AS loesch_fg
FROM kfl_production_dbp_view.v_regio_art_gp_wup_zu_2
WHERE
  mandant_id = 1 AND loesch_fg = 0;
