CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_fakturaart_prompt_1 (fakturaart_id) AS SELECT fakturaart_id
FROM kfl_production_dbp_view.v_l_fakturaart_1 AS V01
GROUP BY fakturaart_id;