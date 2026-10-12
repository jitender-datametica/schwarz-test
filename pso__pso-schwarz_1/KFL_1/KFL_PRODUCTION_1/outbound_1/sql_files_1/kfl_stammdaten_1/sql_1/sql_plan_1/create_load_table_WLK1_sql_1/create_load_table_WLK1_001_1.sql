-- [not OK] statement is not translated correctly-----------------------------------------------------------------
-- original statement
-- SELECT COUNT(*) FROM (
--
----begin subquery
-- SELECT * FROM DBC.tables
-- WHERE   databasename='DBX_LOAD' AND
--        tablename='wlk1_1'
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
        SELECT TABLES.*
        FROM
            dbp_etl.INFORMATION_SCHEMA.TABLES
        WHERE
            UPPER(TABLES.TABLE_SCHEMA) = 'DBP_ETL_1'
            AND UPPER(TABLES.TABLE_NAME) = 'WLK1_1'
    ) AS subselect;
-- end subquery
