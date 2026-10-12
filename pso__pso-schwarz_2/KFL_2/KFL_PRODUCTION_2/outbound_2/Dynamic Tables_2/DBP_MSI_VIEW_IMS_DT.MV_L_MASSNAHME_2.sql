CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_massnahme_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  massnahme_id AS massnahme_id,
  massnahmenart_id AS massnahmenart_id
FROM kfl_production_dbp_view.v_l_massnahme_2;
