CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wrg_1 (wrg_id, wrg_bez, td_update, td_insert) AS SELECT wrg_id,
 wrg_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.wrg_1;