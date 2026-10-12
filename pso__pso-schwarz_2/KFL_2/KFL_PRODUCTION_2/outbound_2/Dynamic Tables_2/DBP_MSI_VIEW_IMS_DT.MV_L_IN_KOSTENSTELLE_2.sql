CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_in_kostenstelle_2
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
  COALESCE(pc_id, '-1') AS pc_id,
  buchungskreis_id AS buchungskreis_id,
  geschaeftsbereich_id AS geschaeftsbereich_id,
  kostenstellenart_id AS kostenstellenart_id
FROM kfl_production_dbp_view.v_in_kostenstelle_per_2
QUALIFY
  (
    ROW_NUMBER() OVER (
      PARTITION BY kostenstelle_id, CAST(mandant_id AS STRING)
      ORDER BY dat_bis IS NULL, dat_bis
    )
  ) = 1;
