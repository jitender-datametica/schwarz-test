CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_l_mv_anlass_zwvermietung
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  anlass_zwvermietung_id AS anlass_zwvermietung_id,
  anlass_zwvermietung_bez AS anlass_zwvermietung_bez
FROM kfl_production_dbp_view.v_immo_l_mv_anlass_zwvermietung AS v0
WHERE
  mandant_id = 1;
