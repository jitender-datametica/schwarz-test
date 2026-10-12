CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_l_wbs_estimation_1 (estimation_id, estimation_bez)
AS SELECT estimation_id,
 estimation_bez
FROM kfl_production_dbp_view.v_wbs_l_estimation_1
GROUP BY estimation_id,
 estimation_bez;