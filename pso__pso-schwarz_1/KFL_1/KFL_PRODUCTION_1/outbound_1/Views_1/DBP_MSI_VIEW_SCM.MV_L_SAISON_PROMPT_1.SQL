CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_l_saison_prompt_1 (saison_id) AS SELECT saison_id
FROM kfl_production_dbp_view.v_l_saison_1
GROUP BY saison_id;