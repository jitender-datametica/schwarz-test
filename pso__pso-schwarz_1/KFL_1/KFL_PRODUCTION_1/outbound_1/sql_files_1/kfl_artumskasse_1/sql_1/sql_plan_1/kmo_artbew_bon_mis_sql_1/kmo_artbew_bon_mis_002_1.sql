-- [OK] statement is translated correctly (syntax and type checks are fine)
SELECT count(*)
-- begin subquery
FROM
    (
        SELECT TABLES.*
        FROM
            dbp_etl_process.INFORMATION_SCHEMA.TABLES
        WHERE
            upper(TABLES.TABLE_SCHEMA) = 'DBP_ETL_PROCESS'
            AND upper(TABLES.TABLE_NAME) = 'POSLOG_AGG_WT_1'
    ) AS subselect;
-- end subquery
