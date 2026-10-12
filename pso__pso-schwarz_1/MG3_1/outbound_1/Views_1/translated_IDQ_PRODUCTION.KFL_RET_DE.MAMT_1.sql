CREATE OR REPLACE VIEW idq_production_kfl_ret_de.mamt_1 (mandt, matnr, spras, meinh, mtxid, lfdnr, maktm, country_code,
td_insert, td_update) AS SELECT mandt,
 matnr,
 spras,
 meinh,
 mtxid,
 lfdnr,
 maktm,
 country_code,
 td_insert,
 td_update
FROM idq_production_kfl_ret.mamt_1
WHERE country_code IN ('DE', 'de');