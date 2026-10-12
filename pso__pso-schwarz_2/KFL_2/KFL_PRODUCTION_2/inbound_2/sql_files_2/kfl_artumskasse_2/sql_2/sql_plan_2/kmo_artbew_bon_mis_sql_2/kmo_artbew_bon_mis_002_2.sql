--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT COUNT(*) FROM (

--begin subquery
SELECT * FROM information_schema.tables
WHERE   UPPER(table_schema) = 'DBP_ETL_PROCESS' AND
        UPPER(table_name) = 'POSLOG_AGG_WT_2'
--end subquery

);

