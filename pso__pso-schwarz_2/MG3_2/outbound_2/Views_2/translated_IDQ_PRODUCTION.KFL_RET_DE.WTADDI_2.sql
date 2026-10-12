CREATE OR REPLACE VIEW idq_production_kfl_ret_de.wtaddi_2 (mandt, matnr, lfdnr, addiclint, addimat, addivkme, addifm,
addiinvoc, addiprass, addicalc, mtxid, country_code, td_insert, td_update) AS SELECT mandt,
 matnr,
 lfdnr,
 addiclint,
 addimat,
 addivkme,
 addifm,
 addiinvoc,
 addiprass,
 addicalc,
 mtxid,
 country_code,
 td_insert,
 td_update
FROM idq_production_kfl_ret.wtaddi_2
WHERE country_code IN ('DE', 'de');