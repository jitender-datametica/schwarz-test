CREATE OR REPLACE VIEW kfl_production_dbp_view.v_profit_center_spr_zu AS SELECT pc_id,
 spr_id,
 mandant_id,
 krk_id,
 system_id,
 pc_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.profit_center_spr_zu;