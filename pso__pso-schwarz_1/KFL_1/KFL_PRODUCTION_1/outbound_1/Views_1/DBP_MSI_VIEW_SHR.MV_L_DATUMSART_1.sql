CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_l_datumsart_1 (mandant_id, datumsart_id) AS SELECT mandant_id,
 datumsart_id
FROM kfl_production_dbp_view.v_l_datumsart_1 AS V01;