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
            UPPER(TABLES.TABLE_SCHEMA) = 'DBP_ETL_1'
            AND upper(TABLES.TABLE_NAME) = upper('vis_ods_tmp_calculation2_1')
    ) AS subselect;
-- end subquery
