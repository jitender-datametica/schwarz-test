CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_l_pruefmerkmal_1 AS SELECT werk_id,
 stp_merkmal_id,
 mandant_id,
 system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_l_pruefmerkmal_1;