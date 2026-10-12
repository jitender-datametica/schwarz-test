--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--SELECT COUNT(*) FROM (
--
----begin subquery
--SELECT * FROM DBC.tables
--WHERE   databasename='DBX_LOAD' AND
--        tablename='wlk1_1'
----end subquery
--
--);
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
SELECT COUNT(*) FROM (

--begin subquery
SELECT * FROM information_schema.tables
WHERE   table_schema='DBP_ETL_1' AND
        table_name='WLK1_1'
--end subquery

);

