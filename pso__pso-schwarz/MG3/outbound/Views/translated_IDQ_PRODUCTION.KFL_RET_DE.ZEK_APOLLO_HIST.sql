CREATE OR REPLACE VIEW idq_production_kfl_ret_de.zek_apollo_hist (mandant, matnr, idnlf, zzek_apollo_ian, datab, datbi,
datae, loekz, utime, country_code, td_insert, td_update) AS SELECT mandant,
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
FROM idq_production_kfl_ret.zek_apollo_hist
WHERE country_code IN ('DE', 'de');