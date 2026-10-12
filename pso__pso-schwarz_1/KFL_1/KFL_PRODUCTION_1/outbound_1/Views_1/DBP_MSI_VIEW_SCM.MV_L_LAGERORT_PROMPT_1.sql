CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_l_lagerort_prompt_1 (lagerort_id) AS SELECT lagerort_id
FROM kfl_production_dbp_view.v_l_lagerort_1
WHERE lagerort_id NOT IN ('-1', '-2', '-3')
GROUP BY lagerort_id;