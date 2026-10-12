CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_land_artikel_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  land_id,
  mandant_id,
  land_bez
FROM kfl_production_dbp_view.v_land_2 AS v02
WHERE
  mandant_id <> 1
  AND (land_id, mandant_id) IN (
    SELECT
      (land_id, CAST(mandant_id AS BIGNUMERIC))
    FROM kfl_production_dbp_view.v_art_2 AS v01
    WHERE
      mandant_id <> 1
  );