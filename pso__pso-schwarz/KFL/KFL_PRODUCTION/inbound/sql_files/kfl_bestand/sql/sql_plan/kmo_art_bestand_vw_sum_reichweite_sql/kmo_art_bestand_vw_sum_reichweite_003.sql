--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT COUNT(*) FROM (

--begin subquery
SELECT mandant_id, COUNT(*), MIN(dat_buch), MAX(dat_buch)
FROM DBP_ETL.kmo_mseg_reichweite
GROUP BY mandant_id

--end subquery

);

