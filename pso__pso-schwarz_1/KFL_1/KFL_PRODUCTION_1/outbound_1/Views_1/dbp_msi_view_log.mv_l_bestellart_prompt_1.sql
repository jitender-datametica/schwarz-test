CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_bestellart_prompt_1 (bestellart_id) AS SELECT bestellart_id
FROM kfl_production_dbp_view.v_l_bestellart_1 AS V01
GROUP BY bestellart_id
UNION DISTINCT
SELECT '-2' AS bestellart_id;