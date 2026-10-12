CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_art_spr_zu
OPTIONS (
  enable_refresh=TRUE,
  refresh_interval_minutes=90,
  max_staleness=INTERVAL '1:30:0' HOUR TO SECOND,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  spr_id,
  art_id,
  mandant_id,
  CASE
    WHEN SUBSTR(art_bez, 1, 11) = 'Wertartikel' AND art_id < 0
    THEN 'Sachkonto WG ' || TRIM(SUBSTR(CAST(art_id / -1000 AS STRING), 1, 20))
    ELSE art_bez
  END AS art_bez,
  SUBSTR(CAST(SUBSTR(CAST(art_id AS STRING), 1, 10) || '   ' || art_bez AS STRING), 1, 100) AS art_id_bez
FROM kfl_production_dbp_view.v_art_spr_zu
WHERE
  spr_id = 22 AND mandant_id = 1;