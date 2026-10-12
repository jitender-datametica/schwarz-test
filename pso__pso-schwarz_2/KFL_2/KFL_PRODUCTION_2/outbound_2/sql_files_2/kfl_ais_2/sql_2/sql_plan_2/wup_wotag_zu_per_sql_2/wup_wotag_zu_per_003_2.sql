-- [OK] statement is translated correctly (syntax and type checks are fine)
SELECT count(*)
-- begin subquery
FROM
    (
        SELECT TABLES.*
        FROM
            dbp_etl.INFORMATION_SCHEMA.TABLES
        WHERE
            upper(TABLES.TABLE_SCHEMA) = 'DBP_ETL_2'
            AND upper(TABLES.TABLE_NAME) = 'ARTBEW_WG_SUM_TMP_2'
    ) AS subselect;
-- end subquery
