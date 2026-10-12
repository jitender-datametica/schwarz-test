CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_kuend_partei_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT DISTINCT
  '1' AS kuend_partei,
  'Vertragsnehmer' AS kuend_partei_bez
FROM kfl_production_dbp_view.v_mandant_2
UNION ALL
SELECT DISTINCT
  '2' AS kuend_partei,
  'Vertragsgeber' AS kuend_partei_bez
FROM kfl_production_dbp_view.v_mandant_2
UNION ALL
SELECT DISTINCT
  '9' AS kuend_partei,
  'Beide' AS kuend_partei_bez
FROM kfl_production_dbp_view.v_mandant_2
UNION ALL
SELECT DISTINCT
  '' AS kuend_partei,
  '' AS kuend_partei_bez
FROM kfl_production_dbp_view.v_mandant_2;
