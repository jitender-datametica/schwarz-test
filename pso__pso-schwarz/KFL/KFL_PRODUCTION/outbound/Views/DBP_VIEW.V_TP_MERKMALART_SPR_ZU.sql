CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tp_merkmalart_spr_zu AS SELECT tp_merkmalart_id,
 spr_id,
 tp_merkmal_id,
 mandant_id,
 tp_merkmalart_bez
FROM kfl_production_dbp_data.tp_merkmalart_spr_zu;