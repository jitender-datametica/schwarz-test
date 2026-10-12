-- [not OK] statement is not translated correctly-----------------------------------------------------------------
-- original statement
-- SELECT COUNT(*) FROM (
--
----begin subquery
-- SELECT * FROM DBC.tables
-- WHERE databasename = 'DBX_LOAD' (NOT CS)
-- AND tablename    = 'gruppe_gruppe_zu_tmp_1' (NOT CS)
----end subquery
--
-- );
--
-- Comment from validation checker
-- MESSAGE: [unixODBC]Incorrect username or password was specified.
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
            AND upper(TABLES.TABLE_NAME) = upper('gruppe_gruppe_zu_tmp_1')
    ) AS subselect;
-- end subquery
