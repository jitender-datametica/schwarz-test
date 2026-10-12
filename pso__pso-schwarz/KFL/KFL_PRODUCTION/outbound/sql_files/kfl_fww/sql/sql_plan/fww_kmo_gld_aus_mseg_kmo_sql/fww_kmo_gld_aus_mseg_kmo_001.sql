/* AW check 2021-05-17*/
SELECT count(*)
-- begin subquery
FROM
    (
        SELECT TABLES.*
        FROM
            dbp_etl.INFORMATION_SCHEMA.TABLES
        WHERE
            upper(TABLES.TABLE_SCHEMA) = 'DBP_ETL'
            AND upper(TABLES.TABLE_NAME) = 'GLD_DAT'
    ) AS subselect;
-- end subquery
