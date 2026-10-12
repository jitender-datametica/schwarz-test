CREATE OR REPLACE VIEW idq_production_kfl_ret_de.makt (mandt, matnr, spras, maktx, maktg, country_code, td_insert,
td_update) AS SELECT mandt,
 matnr,
 spras,
 maktx,
 maktg,
 country_code,
 td_insert,
 td_update
FROM idq_production_kfl_ret.makt
WHERE country_code IN ('HR', 'hr');