CREATE OR REPLACE VIEW kfl_production_dbp_view.v_amx_b_process_pruefung_zu AS SELECT business_process_id,
 pruefung_id,
 amx_system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.amx_b_process_pruefung_zu;