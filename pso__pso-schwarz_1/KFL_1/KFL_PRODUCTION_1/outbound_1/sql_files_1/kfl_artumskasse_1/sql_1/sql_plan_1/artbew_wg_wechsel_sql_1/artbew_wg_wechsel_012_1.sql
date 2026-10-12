-- [OK] statement is translated correctly (syntax and type checks are fine)
-- WARNING : Possible parameter resolution issue
SELECT count(*)
-- begin subquery
FROM
    (
        SELECT TABLES.*
        FROM
            $DBX_ARCHIV.INFORMATION_SCHEMA.TABLES
        WHERE
            upper(TABLES.TABLE_SCHEMA) = '$DBX_ARCHIV'
            AND upper(TABLES.TABLE_NAME) = 'ARTBEW_2016'
    ) AS subselect;
-- end subquery
