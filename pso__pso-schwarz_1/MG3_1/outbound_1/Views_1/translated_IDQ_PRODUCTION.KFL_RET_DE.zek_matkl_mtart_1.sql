CREATE OR REPLACE VIEW idq_production_kfl_ret_de.zek_matkl_mtart_1 (mandt, matkl, mtart, lead_mtart, country_code,
td_insert, td_update) AS SELECT mandt,
 matkl,
 mtart,
 lead_mtart,
 country_code,
 td_insert,
 td_update
FROM idq_production_kfl_ret.zek_matkl_mtart_1
WHERE country_code IN ('DE', 'de');