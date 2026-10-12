--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : Possible parameter resolution issue
--original statement
--SELECT COUNT(*) FROM (
--
----begin subquery
--SELECT * FROM dbc.dbcInfo WHERE $INIT = 1 SAMPLE 1
----end subquery
--
--);
--
--Comment from validation checker
--error line 4 at position 33 unexpected '='.
--SELECT * FROM dbc.dbcInfo WHERE $ ^^^> INIT = 1 LIMIT 1
--translated statement
SELECT COUNT(*) FROM (

--begin subquery
SELECT * FROM dbc.dbcInfo WHERE $INIT = 1 LIMIT 1
--end subquery

);

