CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_fw_wk_national_2 AS SELECT mandant_id,
 fw_wk_national_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.l_fw_wk_national_2;