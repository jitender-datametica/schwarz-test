CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_tp_merkmalart AS SELECT tp_merkmalart_id,
 tp_merkmal_id,
 mandant_id,
 tp_merkmal_klasse_id,
 tp_merkmalwert_id
FROM kfl_production_dbp_data.l_tp_merkmalart;