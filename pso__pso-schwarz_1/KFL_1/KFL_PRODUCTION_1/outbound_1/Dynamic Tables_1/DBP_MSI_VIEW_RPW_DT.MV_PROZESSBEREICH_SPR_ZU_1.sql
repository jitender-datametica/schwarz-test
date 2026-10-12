CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_prozessbereich_spr_zu_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT 7 AS system_id,
 mandant_id,
 prozessbereich_id,
 spr_id,
 prozessbereich_bez
FROM kfl_production_dbp_view.v_prozessbereich_spr_zu_1
WHERE mandant_id = 1
 AND spr_id = 22;