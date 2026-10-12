CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_l_dispomerkmal_prompt (dispomerkmal) AS SELECT
 dispomerkmal
FROM kfl_production_dbp_view.v_l_dispomerkmal AS V01
GROUP BY dispomerkmal;