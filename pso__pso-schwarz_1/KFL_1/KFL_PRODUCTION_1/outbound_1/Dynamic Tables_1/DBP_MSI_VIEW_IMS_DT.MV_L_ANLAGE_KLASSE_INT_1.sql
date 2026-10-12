CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_anlage_klasse_int_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  anlage_klasse_id AS anlage_klasse_id,
  gesperrt_fg AS gesperrt_fg
FROM kfl_production_dbp_view.v_l_anlage_klasse_1
WHERE
  LENGTH(TRIM(COLLATE(anlage_klasse_id, ''), '0')) = 8
  AND NOT ROUND(SAFE_CAST(anlage_klasse_id AS BIGNUMERIC), 0) IS NULL
QUALIFY
  (
    ROW_NUMBER() OVER (PARTITION BY anlage_klasse_id ORDER BY mandant_id IS NULL, mandant_id)
  ) = 1;
