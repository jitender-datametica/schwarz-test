--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT COUNT(*) FROM (

--begin subquery
SELECT mandant_id, COUNT(*), MIN(dat), MAX(DAT)
FROM DBP_ETL.art_best_vw_sum_artbew_kmo_dat_1
GROUP BY mandant_id

--end subquery

);

