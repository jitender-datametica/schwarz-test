CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_bestellart_2 (mandant_id, bestellart_id) AS SELECT mandant_id
 ,
 bestellart_id
FROM kfl_production_dbp_view.v_l_bestellart_2 AS V01
UNION DISTINCT
SELECT mandant_id,
 '-2' AS bestellart_id
FROM kfl_production_dbp_view.v_mandant_2 AS V02;