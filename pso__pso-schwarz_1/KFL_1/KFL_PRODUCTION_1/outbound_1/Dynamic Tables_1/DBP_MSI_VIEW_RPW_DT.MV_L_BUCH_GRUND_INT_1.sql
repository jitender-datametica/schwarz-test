CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_l_buch_grund_int_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT buch_grund_int_id,
 mandant_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_l_buch_grund_int_1
WHERE mandant_id = 1;