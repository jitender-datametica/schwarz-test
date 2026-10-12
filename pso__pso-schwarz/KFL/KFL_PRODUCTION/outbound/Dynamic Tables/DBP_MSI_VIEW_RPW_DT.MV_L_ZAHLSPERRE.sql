CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_l_zahlsperre
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT mandant_id,
 zahlsperre_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_l_zahlsperre
WHERE mandant_id = 1;