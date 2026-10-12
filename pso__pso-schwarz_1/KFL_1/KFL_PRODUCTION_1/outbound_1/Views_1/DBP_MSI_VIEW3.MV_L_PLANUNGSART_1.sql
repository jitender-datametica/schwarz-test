CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_planungsart_1 (mandant_id, planungsart_id) AS SELECT mandant_id,
 planungsart_id
FROM kfl_production_dbp_view.v_l_planungsart_1;