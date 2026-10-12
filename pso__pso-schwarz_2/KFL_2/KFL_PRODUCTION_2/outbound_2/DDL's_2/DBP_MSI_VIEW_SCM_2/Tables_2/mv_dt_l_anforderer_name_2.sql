CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_scm.mv_dt_l_anforderer_name_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 60) AS
SELECT mandant_id,
 anforderer_name
FROM kfl_production_dbp_data.besch_best_det_2
GROUP BY mandant_id,
 anforderer_name;