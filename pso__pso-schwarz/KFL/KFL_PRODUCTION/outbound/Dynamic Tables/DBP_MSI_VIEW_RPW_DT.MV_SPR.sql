CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_spr
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT spr_id,
 spr_name,
 spr_iso,
 dwh_spr,
 7 AS system_id
FROM kfl_production_dbp_view.v_spr
WHERE spr_id = 22;