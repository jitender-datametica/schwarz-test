CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_l_it_gremium_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  it_gremium_id AS it_gremium_id,
  it_gremium_bez AS it_gremium_bez
FROM kfl_production_dbp_view.v_l_it_gremium_2;
