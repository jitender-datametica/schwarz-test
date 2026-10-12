CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_l_konditionsart_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT 7 AS system_id,
 mandant_id,
 konditionsart_id
FROM kfl_production_dbp_view.v_l_konditionsart_1
WHERE mandant_id = 1;