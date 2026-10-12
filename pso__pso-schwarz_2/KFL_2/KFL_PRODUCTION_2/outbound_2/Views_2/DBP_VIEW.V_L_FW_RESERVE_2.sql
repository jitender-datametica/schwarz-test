CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_fw_reserve_2 AS SELECT fw_reserve_id,
 mandant_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.l_fw_reserve_2;