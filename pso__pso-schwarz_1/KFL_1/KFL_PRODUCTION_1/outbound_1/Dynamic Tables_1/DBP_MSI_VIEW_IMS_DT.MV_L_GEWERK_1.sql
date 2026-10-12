CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_gewerk_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
 gewerk_id
FROM kfl_production_dbp_view.v_l_gewerk_1
UNION DISTINCT
SELECT
  -1
FROM kfl_production_dbp_view.v_mandant_1
WHERE
  mandant_id = 1;
