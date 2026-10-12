CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_l_lohnart_1 (mandant_id, lohnart_id) AS SELECT mandant_id,
 lohnart_id
FROM kfl_production_dbp_view.v_l_lohnart_1 AS V01;