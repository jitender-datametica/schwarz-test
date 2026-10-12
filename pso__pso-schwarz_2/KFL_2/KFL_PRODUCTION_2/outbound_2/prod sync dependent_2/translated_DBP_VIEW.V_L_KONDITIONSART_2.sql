CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_konditionsart_2 (mandant_id, konditionsart_id, system_id, td_update,
td_insert) AS SELECT mandant_id,
 konditionsart_id,
 system_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_konditionsart_2;