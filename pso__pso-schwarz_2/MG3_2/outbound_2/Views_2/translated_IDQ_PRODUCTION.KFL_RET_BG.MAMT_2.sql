CREATE OR REPLACE VIEW idq_production_kfl_ret_bg.mamt_2 (mandt, matnr, spras, meinh, mtxid, lfdnr, maktm, country_code,
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
FROM idq_production_kfl_ret.mamt_2
WHERE country_code IN ('BG', 'bg');