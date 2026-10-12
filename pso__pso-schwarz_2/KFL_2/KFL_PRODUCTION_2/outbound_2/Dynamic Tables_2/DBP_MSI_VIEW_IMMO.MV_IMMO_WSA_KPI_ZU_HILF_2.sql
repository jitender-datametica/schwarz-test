CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_immo_wsa_kpi_zu_hilf_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  CASE
    WHEN region_id = '1'
    OR region_id = '2'
    OR region_id = '3'
    OR region_id = '4'
    OR region_id = '5'
    OR region_id = '6'
    OR region_id = '7'
    OR region_id = '8'
    OR region_id = '9'
    THEN '0' || region_id
    ELSE region_id
  END AS region_id,
  branche_id AS branche_id,
  groesse_kategorie AS groesse_kategorie,
  wrg_id AS wrg_id,
  umsatz_produktivitaet AS umsatz_produktivitaet,
  kunde_umsatz AS kunde_umsatz
FROM kfl_production_dbp_view.v_immo_wsa_kpi_2 AS v1;
