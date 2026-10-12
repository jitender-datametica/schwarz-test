CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_l_gp_branche_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT mandant_id,
 gp_branche_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_l_gp_branche_1
WHERE mandant_id = 1;