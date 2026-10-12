CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics_ac.v_ftm_customer_1 (client_id, country_code, dat_formdate, cy_week,
store_id, orig_store_nr, cnt_cust) AS SELECT *
FROM ldl_p_lew_mart_analytics.v_ftm_customer_1;