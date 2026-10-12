CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_l_problemgruppe_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT 7 AS system_id,
 mandant_id,
 problemgruppe_id
FROM kfl_production_dbp_view.v_l_problemgruppe_2
WHERE mandant_id = 1;