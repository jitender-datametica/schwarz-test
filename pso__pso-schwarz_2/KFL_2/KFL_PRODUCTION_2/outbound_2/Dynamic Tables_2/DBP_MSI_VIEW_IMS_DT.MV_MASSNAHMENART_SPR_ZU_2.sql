CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_massnahmenart_spr_zu_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.massnahme_id AS massnahme_id,
  v02.massnahmenart_bez AS massnahmenart_bez
FROM kfl_production_dbp_view.v_l_massnahme_2 AS v01
LEFT JOIN kfl_production_dbp_view.v_massnahmenart_spr_zu_2 AS v02
  ON v01.massnahmenart_id = v02.massnahmenart_id
WHERE
  v02.spr_id = 22;
