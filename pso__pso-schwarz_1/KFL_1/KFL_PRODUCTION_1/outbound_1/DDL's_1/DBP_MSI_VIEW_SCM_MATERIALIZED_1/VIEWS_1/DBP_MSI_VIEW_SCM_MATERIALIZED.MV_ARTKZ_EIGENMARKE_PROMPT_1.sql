-- 2023-02-13,dknop, AP0162072, initial

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_artkz_eigenmarke_prompt_1 (eigenmarke_id) AS SELECT
 eigenmarke_id
FROM kfl_production_dbp_view.v_artkz_eigenmarke_1 AS V01
GROUP BY eigenmarke_id;