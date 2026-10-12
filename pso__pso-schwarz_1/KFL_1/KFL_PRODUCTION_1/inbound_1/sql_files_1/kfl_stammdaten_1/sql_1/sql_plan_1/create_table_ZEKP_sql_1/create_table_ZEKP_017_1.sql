--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--SELECT COUNT(*) FROM (
--
----begin subquery
--SELECT * FROM DBC.tables
--WHERE   databasename='${DWH_COMMON_DBX_LOAD}' AND
--        tablename='art_gp_wup_zu_per_tmp_1'
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
WHERE   UPPER(table_schema)='DBP_ETL_1' AND
        UPPER(table_name)= UPPER('art_gp_wup_zu_per_tmp_1')
--end subquery

);

