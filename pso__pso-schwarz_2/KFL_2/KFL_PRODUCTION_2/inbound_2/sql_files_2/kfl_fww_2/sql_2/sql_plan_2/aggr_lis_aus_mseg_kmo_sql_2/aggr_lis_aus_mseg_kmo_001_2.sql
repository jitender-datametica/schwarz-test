SELECT COUNT(*) FROM (

--begin subquery
SELECT * FROM information_schema.tables
WHERE   UPPER(table_schema) = 'DBP_ETL_2' AND
        UPPER(table_name) = 'KMO_MSEG_DAT_2'
--end subquery

);
