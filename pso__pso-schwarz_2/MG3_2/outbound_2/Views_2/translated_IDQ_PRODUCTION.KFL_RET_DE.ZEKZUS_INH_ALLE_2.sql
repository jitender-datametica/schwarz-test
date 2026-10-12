CREATE OR REPLACE VIEW idq_production_kfl_ret_de.zekzus_inh_alle_2 (mandt, matnr, allergen, udate, erdat, uname, uzeit,
country_code, td_insert, td_update) AS SELECT mandt,
 matnr,
 allergen,
 udate,
 erdat,
 uname,
 uzeit,
 country_code,
 td_insert,
 td_update
FROM idq_production_kfl_ret.zekzus_inh_alle_2
WHERE country_code IN ('DE', 'de');