CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_statuscode_gruppe_zu
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT 7 AS system_id,
 mandant_id,
 statuscode_id,
 statusgruppe_id
FROM kfl_production_dbp_view.v_statuscode_gruppe_zu
WHERE mandant_id = 1;