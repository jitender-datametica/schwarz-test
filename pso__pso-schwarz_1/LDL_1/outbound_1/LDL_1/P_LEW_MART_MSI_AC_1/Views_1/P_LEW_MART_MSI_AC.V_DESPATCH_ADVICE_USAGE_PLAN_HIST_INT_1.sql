CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_despatch_advice_usage_plan_hist_int_1 (byr, advice_usage_target_rate,
advice_edi_target_rate, advice_avail_edi_target_rate, advice_avail_target_rate, advice_target_rate, deleted_fg,
dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_mart_msi.v_despatch_advice_usage_plan_hist_int_1;