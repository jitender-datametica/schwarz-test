CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_l_problemcode_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT mandant_id,
 problemcode_id,
 problemklasse_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_l_problemcode_2
WHERE mandant_id = 1;