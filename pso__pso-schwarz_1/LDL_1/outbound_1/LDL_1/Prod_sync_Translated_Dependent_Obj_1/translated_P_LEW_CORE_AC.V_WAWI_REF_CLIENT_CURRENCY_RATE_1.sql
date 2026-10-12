CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 (client_id, currency_iso_cd, to_currency_iso_cd
, dat_rec_start, dat_rec_end, rate_currency_exchange, load_id) AS SELECT *
FROM ldl_p_lew_core.t_wawi_ref_client_currency_rate_1;