SELECT COUNT(*) FROM (

--begin subquery
SELECT * FROM information_schema.tables
WHERE   UPPER(table_schema) = 'DBP_ETL_2' AND
        UPPER(table_name) = 'ART_WUP_AUTODISPO_FLW_TAG_STAGING_2'
--end subquery

);
