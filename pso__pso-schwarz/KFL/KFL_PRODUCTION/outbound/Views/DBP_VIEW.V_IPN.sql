CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ipn AS SELECT ipn_id,
 ipn_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.ipn;