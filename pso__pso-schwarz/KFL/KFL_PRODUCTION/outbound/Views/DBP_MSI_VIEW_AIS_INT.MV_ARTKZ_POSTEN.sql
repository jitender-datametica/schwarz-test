CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_artkz_posten
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT mandant_id,
 posten_id,
 posten_bez
FROM kfl_production_dbp_view.v_artkz_posten AS V01;