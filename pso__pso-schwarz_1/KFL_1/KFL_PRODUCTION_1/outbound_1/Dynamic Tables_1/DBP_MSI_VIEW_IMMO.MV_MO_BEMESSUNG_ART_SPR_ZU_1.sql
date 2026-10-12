CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_mo_bemessung_art_spr_zu_1
OPTIONS (
  enable_refresh=TRUE,
  refresh_interval_minutes=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  mandant_id AS mandant_id,
  bemessung_art_id AS bemessung_art_id,
  spr_id AS spr_id,
  bemessung_art_bez AS bemessung_art_bez
FROM kfl_production_dbp_view.v_immo_mo_bemessung_art_spr_zu_1
WHERE
  spr_id = 22
UNION ALL
SELECT DISTINCT
  mandant_id,
  '' AS bemessung_art_id,
  22 AS spr_id,
  ' ' AS bemessung_art_bez
FROM kfl_production_dbp_view.v_mandant_1;
