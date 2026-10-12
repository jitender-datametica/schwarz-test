CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_melderegel_count_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  mandant_id AS mandant_id,
  mv_intreno AS mv_intreno,
  kjmo AS kjmo,
  MAX(melderegel) AS melderegel_max
FROM (
  SELECT
    mandant_id,
    mv_intreno,
    kjmo,
    melderegel,
    version,
    rhythmus_art,
    nullumsatz
  FROM kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per_2 AS v1
  WHERE
    version = (
      SELECT
        MAX(version)
      FROM kfl_production_dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per_2 AS v2
      WHERE
        v1.mv_intreno = mv_intreno AND v1.kjmo = kjmo AND v1.melderegel = melderegel
    )
) AS v1
WHERE
  rhythmus_art = '0001' AND nullumsatz <> 'X'
GROUP BY
  mandant_id,
  mv_intreno,
  kjmo;
