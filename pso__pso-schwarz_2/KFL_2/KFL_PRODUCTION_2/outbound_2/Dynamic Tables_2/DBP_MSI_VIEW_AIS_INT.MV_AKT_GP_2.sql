CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_akt_gp_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  gp_id AS akt_gp_id,
  gp_name AS akt_gp_name,
  land_id AS akt_land_id
FROM kfl_production_dbp_view.v_gp_2 AS v01;
