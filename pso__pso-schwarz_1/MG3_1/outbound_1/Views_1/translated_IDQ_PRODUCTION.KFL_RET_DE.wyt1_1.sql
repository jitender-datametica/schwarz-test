CREATE OR REPLACE VIEW idq_production_kfl_ret_de.wyt1_1 (mandt, lifnr, ltsnr, ernam, erdat, country_code, td_insert,
td_update) AS SELECT *
FROM idq_production_kfl_ret.wyt1_1
WHERE country_code IN ('DE', 'de');