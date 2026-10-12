CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_vkl
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT vkl_id,
 gf_id,
 vkl_name,
 mandant_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_vkl
WHERE mandant_id = 1;