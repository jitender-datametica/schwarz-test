CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_nachhaltigkeitslogo_art_zu_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  mandant_id, 
  art_id, 
  nachhaltigkeitslogo_id
FROM (
  SELECT
    mandant_id, 
    art_id, 
    nachhaltigkeitslogo_id
  FROM kfl_production_dbp_view.v_nachhaltigkeitslogo_art_zu_2
  UNION ALL
  SELECT
    mandant_id,
    art_id,
    -999
  FROM kfl_production_dbp_view.v_art_2
)
EXCEPT DISTINCT
SELECT
  mandant_id,
  art_id,
  -999
FROM kfl_production_dbp_view.v_nachhaltigkeitslogo_art_zu_2;