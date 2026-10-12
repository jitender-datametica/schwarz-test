-- translated statement
SELECT count(*)
-- begin subquery
FROM
    (
        SELECT
            TABLES.TABLE_SCHEMA,
            TABLES.TABLE_NAME
        FROM
            dbp_etl.INFORMATION_SCHEMA.TABLES
        WHERE
            UPPER(TABLES.TABLE_SCHEMA) = 'DBP_ETL'
            AND upper(TABLES.TABLE_NAME) = upper('vis_ods_tmp_calculation2')
    ) AS subselect;
-- end subquery
