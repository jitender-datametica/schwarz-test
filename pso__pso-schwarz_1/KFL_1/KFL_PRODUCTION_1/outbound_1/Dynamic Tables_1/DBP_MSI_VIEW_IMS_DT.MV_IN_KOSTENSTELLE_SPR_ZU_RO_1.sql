CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_in_kostenstelle_spr_zu_ro_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  mandant_id AS mandant_id,
  kostenstelle_id AS kostenstelle_id,
  krk_id AS krk_id,
  kostenstelle_bez AS kostenstelle_bez
FROM kfl_production_dbp_view.v_in_kostenstelle_spr_zu_per_1
WHERE
  spr_id = 95
QUALIFY
  (
    ROW_NUMBER() OVER (
      PARTITION BY kostenstelle_id, CAST(mandant_id AS STRING)
      ORDER BY dat_bis IS NULL, dat_bis
    )
  ) = 1;
