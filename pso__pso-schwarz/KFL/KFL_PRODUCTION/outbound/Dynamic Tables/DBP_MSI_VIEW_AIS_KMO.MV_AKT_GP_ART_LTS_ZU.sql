CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_akt_gp_art_lts_zu
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v02.mandant_id AS mandant_id,
  v02.akt_gp_id AS akt_gp_id,
  v02.art_id AS art_id,
  COALESCE(v03.gp_teilsortiment_id, '999999') AS gp_teilsortiment_id
FROM (
  SELECT
    mandant_id,
    gp_id AS akt_gp_id,
    art_id
  FROM kfl_production_dbp_view.v_art_gp_nm_zu_per AS v01
  WHERE
    mandant_id <> 1 AND dat_bis = CAST('9999-12-31' AS DATE)
  GROUP BY
    mandant_id,
    akt_gp_id,
    art_id
) AS v02
LEFT JOIN kfl_production_dbp_view.v_ek_infosatz AS v03
  ON v02.mandant_id = v03.mandant_id
  AND v02.art_id = v03.art_id
  AND v02.akt_gp_id = v03.gp_id
QUALIFY
  (
    RANK() OVER (
      PARTITION BY CAST(v02.mandant_id AS STRING), CAST(v02.akt_gp_id AS STRING), CAST(v02.art_id AS STRING)
      ORDER BY v03.ek_infosatz_id IS NULL, v03.ek_infosatz_id
    )
  ) = 1;
