CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_hgp_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT DISTINCT
  gp_id AS hgp_id,
  gp_name AS hgp_name,
  mandant_id AS mandant_id,
  zek_id AS zek_id
FROM kfl_production_dbp_view.v_gp_1
WHERE
  gp_id IN (
    SELECT
      hgp_id
    FROM kfl_production_dbp_view.v_gp_1
    WHERE
      mandant_id = 1
  )
  AND mandant_id = 1;
