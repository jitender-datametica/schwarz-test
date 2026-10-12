SELECT COUNT(*) FROM (

--begin subquery
SELECT * FROM information_schema.tables
WHERE   UPPER(table_schema) = 'DBP_ETL_1' AND
        UPPER(table_name) = 'KMO_MSEG_DAT_WWC_1'
--end subquery

);
