CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics.v_ftm_currency (client_id, country_code, curr_tot_id, currency_code,
currency_desc, local_currency_fg, to_currency_code, rate_currency_exchange) AS SELECT RCRR.client_id,
 RCTRY.country_iso_cd AS country_code,
 RCRR.curr_tot_id,
 RCRR.currency_iso_cd AS currency_code,
 RCRR.currency_desc,
 RCRR.local_currency_fg,
 RCRR.to_currency_iso_cd AS to_currency_code,
 RCRR.rate_currency_exchange
FROM ldl_p_lew_mart_msi_ac.v_ref_currency AS RCRR
 INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_country AS RCTRY ON RCRR.country_id = RCTRY.country_id;