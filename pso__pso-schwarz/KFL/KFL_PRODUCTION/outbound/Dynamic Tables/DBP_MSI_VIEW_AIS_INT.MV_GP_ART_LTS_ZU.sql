CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_gp_art_lts_zu
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  t0.mandant_id AS mandant_id,
  t0.gp_id AS gp_id,
  t0.art_id AS art_id,
  COALESCE(v03.gp_teilsortiment_id, '999999') AS gp_teilsortiment_id
FROM (
  SELECT
    mandant_id,
    gp_id,
    art_id
  FROM kfl_production_dbp_view.v_art_gp_nm_zu_per AS v01
  GROUP BY
    mandant_id,
    art_id,
    gp_id
) AS t0
LEFT JOIN kfl_production_dbp_view.v_ek_infosatz AS v03
  ON t0.mandant_id = v03.mandant_id AND t0.art_id = v03.art_id AND t0.gp_id = v03.gp_id
QUALIFY
  (
    RANK() OVER (
      PARTITION BY CAST(t0.mandant_id AS STRING), CAST(t0.gp_id AS STRING), CAST(t0.art_id AS STRING)
      ORDER BY v03.ek_infosatz_id IS NULL, v03.ek_infosatz_id
    )
  ) = 1;
