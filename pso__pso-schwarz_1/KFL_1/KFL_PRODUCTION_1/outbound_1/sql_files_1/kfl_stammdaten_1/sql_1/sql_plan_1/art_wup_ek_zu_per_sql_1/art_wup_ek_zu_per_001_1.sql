-- [not OK] statement is not translated correctly-----------------------------------------------------------------
-- original statement
-- SELECT COUNT(*) FROM (
--
----begin subquery
-- SELECT tablename FROM dbc.tables
-- WHERE UPPER(tablename) = 'ART_WUP_GP_TMP_1'
-- AND UPPER(databasename) = UPPER('${DWH_COMMON_DBX_LOAD}')
----end subquery
--
-- );
--
-- Comment from validation checker
-- MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
-- translated statement
SELECT count(*)
-- begin subquery
FROM
    (
        SELECT TABLES.TABLE_NAME
        FROM
            dbp_etl.INFORMATION_SCHEMA.TABLES
        WHERE
            upper(TABLES.TABLE_NAME) = 'ART_WUP_GP_TMP_1'
            AND upper(TABLES.TABLE_SCHEMA) = upper('DBP_ETL_1')
    ) AS subselect;
-- end subquery
