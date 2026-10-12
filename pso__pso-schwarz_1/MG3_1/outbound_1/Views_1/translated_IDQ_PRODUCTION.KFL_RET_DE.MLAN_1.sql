CREATE OR REPLACE VIEW idq_production_kfl_ret_de.mlan_1 (mandt, matnr, aland, taxm1, taxm2, taxm3, taxm4, taxm5, taxm6,
taxm7, taxm8, taxm9, taxim, country_code, td_insert, td_update) AS SELECT mandt,
 matnr,
 aland,
 taxm1,
 taxm2,
 taxm3,
 taxm4,
 taxm5,
 taxm6,
 taxm7,
 taxm8,
 taxm9,
 taxim,
 country_code,
 td_insert,
 td_update
FROM idq_production_kfl_ret.mlan_1
WHERE country_code IN ('DE', 'de');