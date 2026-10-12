CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_ref_currency (curr_tot_id, country_id, client_id, currency_iso_cd,
currency_desc, to_currency_iso_cd, rate_currency_exchange, local_currency_fg) AS SELECT CAST(CASE
   WHEN currency_iso_cd = 'EUR'
   THEN 0
   WHEN currency_iso_cd = 'GBP'
   THEN 40
   ELSE client_id
   END AS BIGNUMERIC) AS curr_tot_id,
 country_id,
 client_id,
 currency_iso_cd,
 currency_desc,
 to_currency_iso_cd,
 rate_currency_exchange,
 CAST(CASE
   WHEN currency_iso_cd = to_currency_iso_cd
   THEN 1
   ELSE 0
   END AS BIGNUMERIC) AS local_currency_fg
FROM ldl_p_lew_core_ac.v_wawi_ref_currency_act;