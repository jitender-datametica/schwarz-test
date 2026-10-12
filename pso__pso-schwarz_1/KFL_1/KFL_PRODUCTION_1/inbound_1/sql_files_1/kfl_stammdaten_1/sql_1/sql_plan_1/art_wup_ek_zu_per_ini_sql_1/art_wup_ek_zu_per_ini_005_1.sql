--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--SELECT COUNT(*) FROM (
--
----begin subquery
--SELECT 1
--WHERE 1=$RB
----end subquery
--
--);
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
SELECT COUNT(*) FROM (

--begin subquery
SELECT 1
WHERE 1=$RB
--end subquery

);

