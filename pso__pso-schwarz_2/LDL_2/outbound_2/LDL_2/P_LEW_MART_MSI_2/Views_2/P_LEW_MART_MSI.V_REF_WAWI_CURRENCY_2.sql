CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_wawi_currency_2 AS SELECT client_id,
 currency_iso_cd,
 currency_nr,
 currency_sign1,
 currency_sign2,
 currency_tolerance,
 dat_valid_from,
 rate_currency_exchange
FROM ldl_p_lew_core_ac.v_wawi_ref_wawi_currency_2 AS T1_2;