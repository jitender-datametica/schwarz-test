CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mcx_l_teilbereich AS SELECT teilbereich_id,
 ber_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.mcx_l_teilbereich;