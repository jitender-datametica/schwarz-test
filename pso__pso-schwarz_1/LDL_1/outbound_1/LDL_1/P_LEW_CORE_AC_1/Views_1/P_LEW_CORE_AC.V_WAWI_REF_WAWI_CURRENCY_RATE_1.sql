CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_wawi_currency_rate_1 (client_id, currency_nr, currency_iso_cd,
dat_valid_from, dat_valid_until, unit_currency_exchange, rate_currency_exchange, dat_dayend, load_id) AS SELECT
 client_id,
 currency_nr,
 currency_iso_cd,
 dat_valid_from,
 dat_valid_until,
 unit_currency_exchange,
 rate_currency_exchange,
 dat_dayend,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_wawi_currency_rate_1;