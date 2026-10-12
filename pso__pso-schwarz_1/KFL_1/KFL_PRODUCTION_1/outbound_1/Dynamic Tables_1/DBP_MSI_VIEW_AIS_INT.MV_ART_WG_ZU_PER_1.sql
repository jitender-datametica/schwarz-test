CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_art_wg_zu_per_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  art_id AS art_id,
  wg_id AS wg_id,
  wug_id AS wug_id,
  arthiertyp_id AS arthiertyp_id
FROM kfl_production_dbp_view.v_art_wg_zu_per_1 AS v01
WHERE
  arthiertyp_id = 2 AND dat_bis = CAST('9999-12-31' AS DATE);
