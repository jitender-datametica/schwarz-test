CREATE OR REPLACE VIEW idq_production_kfl_ret_bg.mast_2 (mandt, matnr, werks, stlan, stlnr, stlal, losvn, losbs, andat,
annam, aedat, aenam, cslty, country_code, td_insert, td_update) AS SELECT mandt,
 matnr,
 werks,
 stlan,
 stlnr,
 stlal,
 losvn,
 losbs,
 andat,
 annam,
 aedat,
 aenam,
 cslty,
 country_code,
 td_insert,
 td_update
FROM idq_production_kfl_ret.mast_2
WHERE country_code IN ('BG', 'bg');