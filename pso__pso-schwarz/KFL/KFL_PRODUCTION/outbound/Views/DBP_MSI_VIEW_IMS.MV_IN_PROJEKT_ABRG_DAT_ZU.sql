CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_in_projekt_abrg_dat_zu AS SELECT V01.mandant_id,
 V01.in_projekt_id,
 MAX(V01.in_projekt_id_char) AS in_projekt_id_char,
 MAX(COALESCE(V02.dat_abschluss, DATE '9999-12-31')) AS dat_,
  CASE
  WHEN MAX(COALESCE(V02.dat_abschluss, DATE '9999-12-31')) = DATE '9999-12-31'
  THEN '2001'
  ELSE CAST(MAX(COALESCE(V02.dat_abschluss, DATE '9999-12-31')) AS STRING)
  END AS abrg_dat
FROM kfl_production_dbp_view.v_in_projekt AS V01
 INNER JOIN kfl_production_dbp_view.v_in_psp_element AS V02 ON V01.in_projekt_id = V02.in_projekt_id AND V01.mandant_id
   = V02.mandant_id
WHERE V02.statistisch_fg = 1
GROUP BY V01.mandant_id,
 V01.in_projekt_id;