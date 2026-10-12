--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--SELECT COUNT(*) FROM (
--
----begin subquery
--SELECT tablename FROM dbc.tables
--WHERE UPPER(tablename) = 'ART_WUP_EK_DATUM_RELEVANT'
--AND UPPER(databasename) = UPPER('${DWH_COMMON_DBX_LOAD}')
----end subquery
--
--);
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
SELECT COUNT(*) FROM (

--begin subquery
SELECT table_name FROM information_schema.tables
WHERE UPPER(table_name) = 'ART_WUP_EK_DATUM_RELEVANT'
AND UPPER(table_schema) = UPPER('DBP_ETL')
--end subquery

);

