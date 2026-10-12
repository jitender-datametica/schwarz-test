CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_vk
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT vk_id,
 vk_bez,
 mandant_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_vk
WHERE mandant_id = 1;