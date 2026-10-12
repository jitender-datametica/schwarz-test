CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_fw_we_hammer AS SELECT fw_we_hammer_id,
 mandant_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.l_fw_we_hammer;