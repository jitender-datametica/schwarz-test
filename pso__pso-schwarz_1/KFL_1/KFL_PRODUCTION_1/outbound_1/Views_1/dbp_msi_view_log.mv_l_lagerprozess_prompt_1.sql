CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_lagerprozess_prompt_1 (lagerprozess_id) AS SELECT
 lagerprozess_id
FROM kfl_production_dbp_view.v_l_lagerprozess_1 AS V01
GROUP BY lagerprozess_id;