CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_transaktion AS SELECT mandant_id,
 transaktion_id
FROM kfl_production_dbp_data.l_transaktion;