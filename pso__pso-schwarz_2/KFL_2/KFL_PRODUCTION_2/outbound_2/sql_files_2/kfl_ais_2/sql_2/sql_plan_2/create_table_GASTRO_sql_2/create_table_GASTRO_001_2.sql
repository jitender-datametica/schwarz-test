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
            AND upper(TABLES.TABLE_NAME) = 'GASTRO_FINANZ_2'
    ) AS subselect;
-- end subquery
