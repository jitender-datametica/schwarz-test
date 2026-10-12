-- [not OK] statement is not translated correctly-----------------------------------------------------------------
-- original statement
-- SELECT COUNT(*) FROM (
--
----begin subquery
-- SELECT * FROM DBC.tables
-- WHERE   databasename='${DWH_COMMON_DBX_LOAD}' AND
--        tablename='art_gp_zu_per_tmp_1'
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
            upper(TABLES.TABLE_SCHEMA) = 'DBP_ETL_1'
            AND upper(TABLES.TABLE_NAME) = upper('art_gp_zu_per_tmp_1')
    ) AS subselect;
-- end subquery
