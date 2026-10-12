CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_it_projekt_status_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  it_projekt_status_id AS it_projekt_status_id
FROM kfl_production_dbp_view.v_l_it_projekt_status_1;
