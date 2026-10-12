-- 2023-02-13,dknop, AP0162072, initial

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_l_saison_prompt (saison_id) AS SELECT saison_id
FROM kfl_production_dbp_view.v_l_saison
GROUP BY saison_id;