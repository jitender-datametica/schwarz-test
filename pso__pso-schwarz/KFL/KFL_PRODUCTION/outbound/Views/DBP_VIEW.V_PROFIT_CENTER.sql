CREATE OR REPLACE VIEW kfl_production_dbp_view.v_profit_center AS SELECT pc_id,
 mandant_id,
 krk_id,
 system_id,
 wup_id,
 nb_id,
 werk_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.profit_center;