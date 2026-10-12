CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_wug
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT wug_id,
 wg_id,
 arthiertyp_id,
 mandant_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_wug
WHERE mandant_id = 1
 AND arthiertyp_id = 2;