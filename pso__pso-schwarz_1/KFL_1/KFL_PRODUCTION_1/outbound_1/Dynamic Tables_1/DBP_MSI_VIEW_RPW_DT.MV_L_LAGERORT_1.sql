CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_l_lagerort_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT mandant_id,
 lagerort_id,
 wup_id,
 nb_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_l_lagerort_1
WHERE mandant_id = 1;