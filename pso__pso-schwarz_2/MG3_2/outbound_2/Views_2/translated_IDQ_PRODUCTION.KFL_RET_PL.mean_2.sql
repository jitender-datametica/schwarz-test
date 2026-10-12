CREATE OR REPLACE VIEW idq_production_kfl_ret_pl.mean_2 (mandt, matnr, meinh, lfnum, ean11, eantp, hpean, sgt_catv,
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
FROM idq_production_kfl_ret.mean_2
WHERE country_code IN ('PL', 'pl');