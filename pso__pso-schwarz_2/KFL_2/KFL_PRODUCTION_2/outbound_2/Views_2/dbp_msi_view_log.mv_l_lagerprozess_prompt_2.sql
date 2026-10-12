CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_lagerprozess_prompt_2 (lagerprozess_id) AS SELECT
 lagerprozess_id
FROM kfl_production_dbp_view.v_l_lagerprozess_2 AS V01
GROUP BY lagerprozess_id;