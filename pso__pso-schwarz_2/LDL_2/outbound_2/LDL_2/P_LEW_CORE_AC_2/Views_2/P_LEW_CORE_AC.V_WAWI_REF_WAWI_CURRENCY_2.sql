CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_wawi_currency_2 (client_id, currency_nr, dat_valid_from,
currency_iso_cd, rate_currency_exchange, currency_tolerance, currency_sign1, currency_sign2, load_id) AS SELECT
 client_id,
 currency_nr,
 dat_valid_from,
 currency_iso_cd,
 rate_currency_exchange,
 currency_tolerance,
 currency_sign1,
 currency_sign2,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_wawi_currency_2;