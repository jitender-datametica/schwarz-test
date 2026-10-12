SELECT name AS `_table_name`
FROM sys.tables AS t
WHERE SCHEMA_NAME(schema_id) = 'dbo'
 AND name LIKE '%REF%'
ORDER BY `_table_name` NULLS LAST;