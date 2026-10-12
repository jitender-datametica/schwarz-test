CREATE OR REPLACE VIEW idq_production_kfl_ret_de.t179t (mandt, spras, prodh, vtext, country_code, td_insert, td_update)
AS SELECT mandt,
 spras,
 prodh,
 vtext,
 country_code,
 td_insert,
 td_update
FROM idq_production_kfl_ret.t179t
WHERE country_code IN ('DE', 'de');