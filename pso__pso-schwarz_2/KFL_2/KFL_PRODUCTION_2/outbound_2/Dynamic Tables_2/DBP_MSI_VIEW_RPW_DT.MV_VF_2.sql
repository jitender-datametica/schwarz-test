CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_vf_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT vf_id,
 vf_name,
 mandant_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_vf_2
WHERE mandant_id = 1;