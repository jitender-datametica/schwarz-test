CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_ref_currency (curr_tot_id, country_id, client_id, currency_iso_cd,
currency_desc, to_currency_iso_cd, rate_currency_exchange, local_currency_fg) AS SELECT *
FROM ldl_p_lew_mart_lead.v_ref_currency;