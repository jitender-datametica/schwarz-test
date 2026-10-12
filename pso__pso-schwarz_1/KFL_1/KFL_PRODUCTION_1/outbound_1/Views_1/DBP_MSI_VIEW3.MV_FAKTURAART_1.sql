CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_fakturaart_1 (mandant_id, fakturaart_id) AS SELECT mandant_id,
 fakturaart_id
FROM kfl_production_dbp_view.v_l_fakturaart_1;