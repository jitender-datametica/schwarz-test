CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_land_artikel
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
FROM kfl_production_dbp_view.v_land AS v02
WHERE
  mandant_id <> 1
  AND (land_id, mandant_id) IN (
    SELECT
      (land_id, CAST(mandant_id AS BIGNUMERIC))
    FROM kfl_production_dbp_view.v_art AS v01
    WHERE
      mandant_id <> 1
  );