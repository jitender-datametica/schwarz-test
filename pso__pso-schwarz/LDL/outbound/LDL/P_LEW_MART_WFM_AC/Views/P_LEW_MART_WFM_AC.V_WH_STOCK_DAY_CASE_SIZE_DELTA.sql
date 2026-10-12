CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm_ac.v_wh_stock_day_case_size_delta (client_id, wh_id, item, case_size,
stock_dat, stock, load_id) AS SELECT *
FROM ldl_p_lew_mart_wfm.v_wh_stock_day_case_size_delta;