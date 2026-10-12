CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_groesse_kategorie
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT DISTINCT
  '01' AS groesse_kategorie,
  0 AS groesse_von,
  150 AS groesse_bis
FROM kfl_production_dbp_view.v_mandant
UNION ALL
SELECT DISTINCT
  '02' AS groesse_kategorie,
  150.01 AS groesse_von,
  999999 AS groesse_bis
FROM kfl_production_dbp_view.v_mandant
UNION ALL
SELECT DISTINCT
  '03' AS groesse_kategorie,
  0 AS groesse_von,
  80 AS groesse_bis
FROM kfl_production_dbp_view.v_mandant
UNION ALL
SELECT DISTINCT
  '04' AS groesse_kategorie,
  80.01 AS groesse_von,
  150 AS groesse_bis
FROM kfl_production_dbp_view.v_mandant
UNION ALL
SELECT DISTINCT
  '05' AS groesse_kategorie,
  0 AS groesse_von,
  100 AS groesse_bis
FROM kfl_production_dbp_view.v_mandant
UNION ALL
SELECT DISTINCT
  '06' AS groesse_kategorie,
  100.01 AS groesse_von,
  200 AS groesse_bis
FROM kfl_production_dbp_view.v_mandant
UNION ALL
SELECT DISTINCT
  '07' AS groesse_kategorie,
  0 AS groesse_von,
  999999 AS groesse_bis
FROM kfl_production_dbp_view.v_mandant
UNION ALL
SELECT DISTINCT
  '08' AS groesse_kategorie,
  0 AS groesse_von,
  200 AS groesse_bis
FROM kfl_production_dbp_view.v_mandant;
