CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_currency_act_2 (country_id, client_id, currency_desc, currency_iso_cd
, to_currency_iso_cd, rate_currency_exchange) AS SELECT country_id,
 client_id,
 currency_desc,
 currency_iso_cd,
 to_currency_iso_cd,
 rate_currency_exchange
FROM ldl_p_lew_core.t_wawi_ref_currency_act_2;