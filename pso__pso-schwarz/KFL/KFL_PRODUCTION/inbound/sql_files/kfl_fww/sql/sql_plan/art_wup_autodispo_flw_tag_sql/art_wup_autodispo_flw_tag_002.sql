SELECT COUNT(*) FROM (

--begin subquery
SELECT * FROM information_schema.tables
WHERE   UPPER(table_schema) = 'DBP_ETL' AND
        UPPER(table_name) = 'ART_WUP_AUTODISPO_FLW_TAG_STAGING'
--end subquery

);
