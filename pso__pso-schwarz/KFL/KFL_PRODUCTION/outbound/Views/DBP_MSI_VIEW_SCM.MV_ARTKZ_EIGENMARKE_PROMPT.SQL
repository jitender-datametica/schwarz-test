CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_artkz_eigenmarke_prompt (eigenmarke_id) AS SELECT
 eigenmarke_id
FROM kfl_production_dbp_view.v_artkz_eigenmarke AS V01
GROUP BY eigenmarke_id;