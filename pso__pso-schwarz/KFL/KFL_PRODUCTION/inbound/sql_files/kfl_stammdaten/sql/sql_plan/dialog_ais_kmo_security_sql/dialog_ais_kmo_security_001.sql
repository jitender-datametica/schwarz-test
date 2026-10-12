--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--SELECT COUNT(*) FROM (
--
----begin subquery
--SELECT * FROM DBC.tables
--WHERE databasename = 'DBX_LOAD' (NOT CS)
--AND tablename    = 'gruppe_gruppe_zu_tmp' (NOT CS)
----end subquery
--
--);
--
--Comment from validation checker
--MESSAGE: [unixODBC]Incorrect username or password was specified.
--translated statement
SELECT COUNT(*) FROM (

--begin subquery
SELECT * FROM information_schema.tables
WHERE table_schema = 'DBP_ETL' collate 'en-ci'
AND table_name    = 'gruppe_gruppe_zu_tmp' collate 'en-ci'
--end subquery

);

