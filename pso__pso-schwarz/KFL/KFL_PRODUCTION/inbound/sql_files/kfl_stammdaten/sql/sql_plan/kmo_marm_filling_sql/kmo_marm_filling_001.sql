--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT COUNT(*) FROM (

--begin subquery
SELECT matnr FROM DBP_ETL.kmo_marm LIMIT 1
--end subquery

);

