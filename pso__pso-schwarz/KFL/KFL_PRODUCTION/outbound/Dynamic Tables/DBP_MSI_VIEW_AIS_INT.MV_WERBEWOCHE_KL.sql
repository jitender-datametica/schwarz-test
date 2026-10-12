CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_werbewoche_kl
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  mandant_id AS mandant_id,
  dat AS dat,
  akt_kjwo_ww AS akt_kjwo_ww,
  akt_kjwo_ww_komplett AS akt_kjwo_ww_komplett,
  kjwo_ww AS kjwo_ww,
  angepasste_kjwo_ww AS angepasste_kjwo_ww,
  SUBSTR(CAST(kjwo_ww AS STRING), 5, 2) AS wo_ww,
  MIN(dat) OVER (
    PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo_ww AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  ) AS ww_dat_von,
  MAX(dat) OVER (
    PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo_ww AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  ) AS ww_dat_bis,
  EXTRACT(YEAR FROM MIN(dat) OVER (
    PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo_ww AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  )) * 100 + EXTRACT(MONTH FROM MIN(dat) OVER (
    PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo_ww AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  )) AS ww_mo,
  RANK() OVER (
    PARTITION BY CAST(mandant_id AS STRING), CAST(kjwo_ww AS STRING)
    ORDER BY dat IS NULL, dat
  ) AS ww_tag
FROM kfl_production_dbp_data.werbewoche_kl;
