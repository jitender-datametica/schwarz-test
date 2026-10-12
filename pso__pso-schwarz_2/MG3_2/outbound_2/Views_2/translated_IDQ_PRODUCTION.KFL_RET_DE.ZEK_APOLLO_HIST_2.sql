CREATE OR REPLACE VIEW idq_production_kfl_ret_de.zek_apollo_hist_2 (mandant_2, matnr, idnlf, zzek_apollo_ian, datab, datbi,
datae, loekz, utime, country_code, td_insert, td_update) AS SELECT mandant_2,
 matnr,
 idnlf,
 zzek_apollo_ian,
 datab,
 datbi,
 datae,
 loekz,
 utime,
 country_code,
 td_insert,
 td_update
FROM idq_production_kfl_ret.zek_apollo_hist_2
WHERE country_code IN ('DE', 'de');