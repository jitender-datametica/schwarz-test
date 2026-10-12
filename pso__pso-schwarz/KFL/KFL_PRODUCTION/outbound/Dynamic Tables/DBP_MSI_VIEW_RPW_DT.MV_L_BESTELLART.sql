CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_l_bestellart
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT mandant_id,
 bestellart_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_l_bestellart
WHERE mandant_id = 1;