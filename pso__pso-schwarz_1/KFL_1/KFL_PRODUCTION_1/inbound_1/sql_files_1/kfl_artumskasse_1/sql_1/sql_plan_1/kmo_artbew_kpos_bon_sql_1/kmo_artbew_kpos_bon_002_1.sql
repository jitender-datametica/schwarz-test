--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT COUNT(*) FROM (

--begin subquery
SELECT * FROM information_schema.tables
WHERE   UPPER(table_schema) = 'DBP_ETL_1' AND
        UPPER(table_name) = 'KMO_WPUUMS_ART_GP_WUP_ZU_1'
--end subquery

);

