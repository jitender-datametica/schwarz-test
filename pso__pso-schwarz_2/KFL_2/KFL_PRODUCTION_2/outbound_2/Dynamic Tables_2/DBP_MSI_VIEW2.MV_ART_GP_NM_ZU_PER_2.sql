CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_art_gp_nm_zu_per_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  art_id AS art_id,
  gp_id AS gp_id,
  mandant_id AS mandant_id,
  wup_id AS wup_id,
  CASE WHEN dat_bis = CAST('9999-12-31' AS DATE) THEN 'a' ELSE 'h' END AS aktuell_fg
FROM kfl_production_dbp_view.v_art_gp_nm_zu_per_2
WHERE
  mandant_id = 1
QUALIFY
  (
    SUM(1) OVER (
      PARTITION BY CAST(art_id AS STRING), CAST(gp_id AS STRING), CAST(mandant_id AS STRING), CAST(wup_id AS STRING)
      ORDER BY dat_bis IS NULL, dat_bis
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    )
  ) = 1;
