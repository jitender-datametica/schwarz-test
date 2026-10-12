CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mcx_zeitspanne_spr_zu AS SELECT zeitspanne_id,
 spr_id,
 zeitspanne_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.mcx_zeitspanne_spr_zu;