CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_wg_wup_sm_zu_per_2
CLUSTER BY wup_id, wg_id, nb_id, dat_von
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  mandant_id,
  wup_id,
  wg_id,
  nb_id,
  dat_von,
  arthiertyp_id,
  dat_bis,
  CASE
    WHEN sm_id IS NULL
    THEN CAST(TRIM(ksm_id) AS STRING)
    WHEN ksm_id IS NULL
    THEN CAST(TRIM(SUBSTR(CAST(sm_id AS STRING), 1, 39)) AS STRING)
    ELSE NULL
  END AS sm_id,
  ksm_id
FROM kfl_production_dbp_view.v_sm_wup_wg_zu_per_2
WHERE
  mandant_id <> 1 AND arthiertyp_id = 2 AND dat_bis = CAST('9999-12-31' AS DATE);