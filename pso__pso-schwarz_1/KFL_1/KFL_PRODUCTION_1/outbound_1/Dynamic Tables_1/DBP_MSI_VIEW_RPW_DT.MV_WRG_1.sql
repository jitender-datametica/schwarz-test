CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_wrg_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT wrg_id,
 wrg_bez
FROM kfl_production_dbp_view.v_wrg_1;