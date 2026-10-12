CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_l_datumsart_2 (mandant_id, datumsart_id) AS SELECT mandant_id,
 datumsart_id
FROM kfl_production_dbp_view.v_l_datumsart_2 AS V01;