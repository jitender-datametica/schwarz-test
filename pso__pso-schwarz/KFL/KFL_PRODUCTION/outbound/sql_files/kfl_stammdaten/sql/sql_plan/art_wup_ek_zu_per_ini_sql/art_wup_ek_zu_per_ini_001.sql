-- [not OK] statement is not translated correctly-----------------------------------------------------------------
-- original statement
-- SELECT COUNT(*) FROM (
--
----begin subquery
-- SELECT tablename FROM dbc.tables
-- WHERE UPPER(tablename) = 'ART_WUP_EK_DATUM_RELEVANT'
-- AND UPPER(databasename) = UPPER('${DWH_COMMON_DBX_LOAD}')
----end subquery
--
-- );
--
-- Comment from validation checker
-- MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
-- translated statement
SELECT count(*)
-- begin subquery
FROM
    (
        SELECT TABLES.TABLE_NAME
        FROM
            dbp_etl.INFORMATION_SCHEMA.TABLES
        WHERE
            upper(TABLES.TABLE_NAME) = 'ART_WUP_EK_DATUM_RELEVANT'
            AND upper(TABLES.TABLE_SCHEMA) = upper('DBP_ETL')
    ) AS subselect;
-- end subquery
