CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_fakturaart_prompt (fakturaart_id) AS SELECT fakturaart_id
FROM kfl_production_dbp_view.v_l_fakturaart AS V01
GROUP BY fakturaart_id;