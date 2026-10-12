CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_rohstoff_preisentwicklung_1 (rohstoff_nr, dat_rohstoff_preis
, max_dat_rohstoff_preis, max_dat_rohstoff_preis_vj, max_dat_rohstoff_preis_vhj, max_dat_rohstoff_preis_vq,
max_dat_rohstoff_preis_vm, kjwo, wrg_id, rohstoff_einh_name, rohstoff_einh_name_abbr, preis_rohstoff_max,
preis_rohstoff_min, preis_rohstoff_avg, preis_gefuellt_fg) AS SELECT rohstoff_nr,
 dat_rohstoff_preis,
 MAX(dat_rohstoff_preis) OVER (PARTITION BY rohstoff_nr, rohstoff_einh_name RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS max_dat_rohstoff_preis,
 DATE_ADD(MAX(dat_rohstoff_preis) OVER (PARTITION BY rohstoff_nr, rohstoff_einh_name RANGE BETWEEN UNBOUNDED PRECEDING
   AND UNBOUNDED FOLLOWING), INTERVAL - 52 WEEK) AS max_dat_rohstoff_preis_vj,
 DATE_ADD(MAX(dat_rohstoff_preis) OVER (PARTITION BY rohstoff_nr, rohstoff_einh_name RANGE BETWEEN UNBOUNDED PRECEDING
   AND UNBOUNDED FOLLOWING), INTERVAL - 26 WEEK) AS max_dat_rohstoff_preis_vhj,
 DATE_ADD(MAX(dat_rohstoff_preis) OVER (PARTITION BY rohstoff_nr, rohstoff_einh_name RANGE BETWEEN UNBOUNDED PRECEDING
   AND UNBOUNDED FOLLOWING), INTERVAL - 13 WEEK) AS max_dat_rohstoff_preis_vq,
 DATE_ADD(MAX(dat_rohstoff_preis) OVER (PARTITION BY rohstoff_nr, rohstoff_einh_name RANGE BETWEEN UNBOUNDED PRECEDING
   AND UNBOUNDED FOLLOWING), INTERVAL - 4 WEEK) AS max_dat_rohstoff_preis_vm,
 kjwo,
 wrg_id,
 rohstoff_einh_name,
  CASE
  WHEN rohstoff_einh_name = 'kilogram'
  THEN 'kg'
  WHEN rohstoff_einh_name = 'liter'
  THEN 'l'
  WHEN rohstoff_einh_name = 'megawatt hour'
  THEN 'mwh'
  WHEN rohstoff_einh_name = 'tonne (metric ton)'
  THEN 'to'
  ELSE NULL
  END AS rohstoff_einh_name_abbr,
 preis_rohstoff_max,
 preis_rohstoff_min,
 preis_rohstoff_avg,
 preis_gefuellt_fg
FROM kfl_production_dbp_data.rohstoff_preisentwicklung_1
WHERE rohstoff_einh_name IN ('kilogram', 'liter', 'megawatt hour', 'tonne (metric ton)')
 AND wrg_id = 'EUR';