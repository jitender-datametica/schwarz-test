CREATE OR REPLACE VIEW idq_production_kfl_ret_pl.mean_1 (mandt, matnr, meinh, lfnum, ean11, eantp, hpean, sgt_catv,
country_code, td_insert, td_update) AS SELECT mandt,
 matnr,
 meinh,
 lfnum,
 ean11,
 eantp,
 hpean,
 sgt_catv,
 country_code,
 td_insert,
 td_update
FROM idq_production_kfl_ret.mean_1
WHERE country_code IN ('PL', 'pl');