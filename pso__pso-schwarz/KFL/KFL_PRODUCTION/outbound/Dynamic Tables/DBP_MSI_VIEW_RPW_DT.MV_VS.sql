CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_vs
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT vs_id,
 vs_bez,
 vk_id,
 mandant_id,
 vsvt_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_vs
WHERE mandant_id = 1;