CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_techn_platz_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  techn_platz_id AS techn_platz_id
FROM kfl_production_dbp_view.v_techn_platz_per_1 AS v01
WHERE
  dat_bis = CAST('9999-12-31' AS DATE);
