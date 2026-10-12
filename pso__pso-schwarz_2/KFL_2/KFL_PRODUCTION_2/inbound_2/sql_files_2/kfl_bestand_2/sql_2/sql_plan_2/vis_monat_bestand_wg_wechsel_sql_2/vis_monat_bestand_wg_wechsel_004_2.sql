--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT COUNT(*) FROM (

--begin subquery
SELECT * FROM information_schema.tables
WHERE   UPPER(table_schema) = 'DBP_ETL_2' AND
        UPPER(table_name) = 'VIS_MONAT_BEST_WG_WECHSEL_LOG_2'
--end subquery

);

