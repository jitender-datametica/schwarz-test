CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_we_region_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  mandant_id,
  mandant_kbez,
  'E' AS we_region,
  'Süd-West' AS kurzbeschreibung
FROM kfl_production_dbp_view.v_mandant_2
UNION ALL
SELECT
  mandant_id,
  mandant_kbez,
  'D' AS we_region,
  'West' AS kurzbeschreibung
FROM kfl_production_dbp_view.v_mandant_2
UNION ALL
SELECT
  mandant_id,
  mandant_kbez,
  'C' AS we_region,
  'Süd-Ost' AS kurzbeschreibung
FROM kfl_production_dbp_view.v_mandant_2
UNION ALL
SELECT
  mandant_id,
  mandant_kbez,
  'N' AS we_region,
  'Ost' AS kurzbeschreibung
FROM kfl_production_dbp_view.v_mandant_2
UNION ALL
SELECT
  mandant_id,
  mandant_kbez,
  'O' AS we_region,
  'Mitte' AS kurzbeschreibung
FROM kfl_production_dbp_view.v_mandant_2
UNION ALL
SELECT
  mandant_id,
  mandant_kbez,
  'S' AS we_region,
  'Sonstige' AS kurzbeschreibung
FROM kfl_production_dbp_view.v_mandant_2
UNION ALL
SELECT
  mandant_id,
  mandant_kbez,
  'W' AS we_region,
  'Nord' AS kurzbeschreibung
FROM kfl_production_dbp_view.v_mandant_2
UNION ALL
SELECT
  mandant_id,
  mandant_kbez,
  '1' AS we_region,
  'Region_2 1' AS kurzbeschreibung
FROM kfl_production_dbp_view.v_mandant_2
UNION ALL
SELECT
  mandant_id,
  mandant_kbez,
  '2' AS we_region,
  'Region_2 2' AS kurzbeschreibung
FROM kfl_production_dbp_view.v_mandant_2
UNION ALL
SELECT
  mandant_id,
  mandant_kbez,
  '3' AS we_region,
  'Region_2 3' AS kurzbeschreibung
FROM kfl_production_dbp_view.v_mandant_2
UNION ALL
SELECT
  mandant_id,
  mandant_kbez,
  'Y' AS we_region,
  'Süd' AS kurzbeschreibung
FROM kfl_production_dbp_view.v_mandant_2
UNION ALL
SELECT
  mandant_id AS mandant_id,
  mandant_kbez AS mandant_kbez,
  'n.v.' AS we_region,
  mandant_bez AS kurzbeschreibung
FROM kfl_production_dbp_view.v_mandant_2;
