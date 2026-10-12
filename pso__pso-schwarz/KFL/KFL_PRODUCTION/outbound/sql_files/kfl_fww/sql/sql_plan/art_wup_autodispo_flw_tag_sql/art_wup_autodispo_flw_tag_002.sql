SELECT count(*)
-- begin subquery
FROM
    (
        SELECT TABLES.*
        FROM
            dbp_etl.INFORMATION_SCHEMA.TABLES
        WHERE
            upper(TABLES.TABLE_SCHEMA) = 'DBP_ETL'
            AND upper(TABLES.TABLE_NAME) = 'ART_WUP_AUTODISPO_FLW_TAG_STAGING'
    ) AS subselect;
-- end subquery
