CREATE OR REPLACE VIEW idq_production_kfl_ret_pl.zek_owgt_2 (mandt, spras, matkl, owg, owg_desc, country_code, td_insert,
td_update) AS SELECT mandt,
 spras,
 matkl,
 owg,
 owg_desc,
 country_code,
 td_insert,
 td_update
FROM idq_production_kfl_ret.zek_owgt_2
WHERE country_code IN ('PL', 'pl');