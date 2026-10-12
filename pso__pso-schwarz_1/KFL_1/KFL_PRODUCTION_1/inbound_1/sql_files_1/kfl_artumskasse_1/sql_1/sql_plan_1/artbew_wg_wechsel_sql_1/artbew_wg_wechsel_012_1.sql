--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Possible parameter resolution issue
SELECT COUNT(*) FROM (

--begin subquery
SELECT * FROM information_schema.tables
WHERE   UPPER(table_schema) = '$DBX_ARCHIV' AND
        UPPER(table_name) = 'ARTBEW_2016'
--end subquery

);

