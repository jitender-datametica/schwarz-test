CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_nb_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT nb_id,
 nb_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_nb_2
WHERE nb_id IN (-111, 0, 2, 99);