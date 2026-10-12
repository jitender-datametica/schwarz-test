CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_in_l_wg_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  in_wg_id AS in_wg_id,
  mandant_id AS mandant_id
FROM kfl_production_dbp_view.v_in_l_wg_1 AS v01;
