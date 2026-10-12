CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_l_clear_stock_2 AS SELECT mandant_id,
 clear_stock_id,
 clear_stock_bez
FROM kfl_production_dbp_view.v_l_clear_stock_2;