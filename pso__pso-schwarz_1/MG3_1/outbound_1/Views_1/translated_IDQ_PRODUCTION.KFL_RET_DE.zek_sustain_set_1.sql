CREATE OR REPLACE VIEW idq_production_kfl_ret_de.zek_sustain_set_1 (mandt, matnr, kzstg, country_code, td_insert,
td_update) AS SELECT mandt,
 matnr,
 kzstg,
 country_code,
 td_insert,
 td_update
FROM idq_production_kfl_ret.zek_sustain_set_1
WHERE country_code IN ('DE', 'de');