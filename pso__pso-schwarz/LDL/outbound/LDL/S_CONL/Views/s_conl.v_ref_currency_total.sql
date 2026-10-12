CREATE OR REPLACE VIEW ldl_s_conl.v_ref_currency_total AS SELECT CASE
  WHEN currency_iso_cd = 'EUR'
  THEN 0
  WHEN currency_iso_cd = 'GBP'
  THEN 40
  ELSE client_id
  END AS curr_tot_id,
 currency_iso_cd,
 currency_desc
FROM ldl_p_lew_core_ac.v_wawi_ref_currency_act
GROUP BY curr_tot_id,
 currency_iso_cd,
 currency_desc;