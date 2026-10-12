CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_gp_datenversorgung_ext_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT DISTINCT
  gp_id AS gp_id,
  gp_name AS gp_name
FROM kfl_production_dbp_view.v_gp_1
WHERE
  gp_id IN (1922320, 3098740, 3126380, 10015214, 10022115);
