-- [OK] statement is translated correctly (syntax and type checks are fine)
SELECT count(*)
-- begin subquery
FROM
    (
        SELECT TABLES.*
        FROM
            dbp_etl.INFORMATION_SCHEMA.TABLES
        WHERE
            upper(TABLES.TABLE_SCHEMA) = 'DBP_ETL_1'
            AND upper(TABLES.TABLE_NAME) = 'ART_UMBEWERTUNG_TEMP_1'
    ) AS subselect;
-- end subquery
