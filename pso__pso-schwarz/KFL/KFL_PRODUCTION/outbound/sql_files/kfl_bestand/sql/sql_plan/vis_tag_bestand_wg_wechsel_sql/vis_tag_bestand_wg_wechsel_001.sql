-- [OK] statement is translated correctly (syntax and type checks are fine)
SELECT count(*)
-- begin subquery
FROM
    (
        SELECT TABLES.*
        FROM
            dbp_etl.INFORMATION_SCHEMA.TABLES
        WHERE
            upper(TABLES.TABLE_SCHEMA) = 'DBP_ETL'
            AND upper(TABLES.TABLE_NAME) = 'VIS_TAG_BESTAND_WG_WECHSEL_LOG'
    ) AS subselect;
-- end subquery
