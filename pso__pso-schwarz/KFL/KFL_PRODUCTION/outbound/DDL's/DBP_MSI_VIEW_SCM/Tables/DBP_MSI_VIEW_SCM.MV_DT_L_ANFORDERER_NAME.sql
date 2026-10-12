CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_scm.mv_dt_l_anforderer_name
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 60) AS
SELECT mandant_id,
 anforderer_name
FROM kfl_production_dbp_data.besch_best_det
GROUP BY mandant_id,
 anforderer_name;