CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics_ac.v_ftm_currency_2 (client_id, country_code, curr_tot_id, currency_code,
currency_desc, local_currency_fg, to_currency_code, rate_currency_exchange) AS SELECT *
FROM ldl_p_lew_mart_analytics.v_ftm_currency_2;