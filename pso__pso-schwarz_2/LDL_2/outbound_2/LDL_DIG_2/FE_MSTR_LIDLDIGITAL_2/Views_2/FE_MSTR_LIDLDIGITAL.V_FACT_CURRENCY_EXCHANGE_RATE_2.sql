CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_currency_exchange_rate_2 (from_curr_cd, to_curr_cd,
curr_exchange_rate_type_cd, exchange_rate) AS SELECT from_curr_cd,
  CASE
  WHEN to_curr_cd = ''
  THEN '-1'
  ELSE IFNULL(to_curr_cd, '-1')
  END AS to_curr_cd,
  CASE
  WHEN curr_exchange_rate_type_cd = ''
  THEN '-1'
  ELSE IFNULL(curr_exchange_rate_type_cd, '-1')
  END AS curr_exchange_rate_type_cd,
 exchange_rate
FROM ldl_dig_lec_share.v_fact_currency_exchange_rate_2
WHERE active_fg;