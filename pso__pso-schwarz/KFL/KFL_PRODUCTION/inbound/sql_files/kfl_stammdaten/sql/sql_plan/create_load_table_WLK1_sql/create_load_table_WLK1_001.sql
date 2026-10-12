--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--SELECT COUNT(*) FROM (
--
----begin subquery
--SELECT * FROM DBC.tables
--WHERE   databasename='DBX_LOAD' AND
--        tablename='wlk1'
----end subquery
--
--);
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
SELECT COUNT(*) FROM (

--begin subquery
SELECT * FROM information_schema.tables
WHERE   table_schema='DBP_ETL' AND
        table_name='WLK1'
--end subquery

);

