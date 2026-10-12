--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT COUNT(*) FROM (

--begin subquery
SELECT * FROM information_schema.tables
WHERE   UPPER(table_schema) = 'DBP_ETL' AND
        UPPER(table_name) = 'ARTBEW_ABT_SUM_TAG_WORK'
--end subquery

);

