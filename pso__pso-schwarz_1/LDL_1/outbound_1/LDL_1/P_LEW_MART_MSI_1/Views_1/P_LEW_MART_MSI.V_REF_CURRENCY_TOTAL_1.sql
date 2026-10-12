CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_currency_total_1 AS SELECT CASE
  WHEN currency_iso_cd = 'EUR'
  THEN 0
  WHEN currency_iso_cd = 'GBP'
  THEN 40
  ELSE client_id
  END AS curr_tot_id,
 currency_iso_cd,
 currency_desc,
  CASE
  WHEN currency_iso_cd = 'HRK'
  THEN - CASE
   WHEN currency_iso_cd = 'EUR'
   THEN 0
   WHEN currency_iso_cd = 'GBP'
   THEN 40
   ELSE client_id
   END
  ELSE CASE
   WHEN currency_iso_cd = 'EUR'
   THEN 0
   WHEN currency_iso_cd = 'GBP'
   THEN 40
   ELSE client_id
   END
  END AS currency_sort
FROM ldl_p_lew_core_ac.v_wawi_ref_currency_act_1
GROUP BY curr_tot_id,
 currency_iso_cd,
 currency_desc,
 currency_sort;