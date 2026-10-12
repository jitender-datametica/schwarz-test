CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_handling_unit_status AS SELECT mandant_id,
 hu_status_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_handling_unit_status;