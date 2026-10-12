
--translated statement
SELECT COUNT(*) FROM (

--begin subquery
SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_schema = 'DBP_ETL_1' collate 'en-ci'
  AND table_name = 'vis_ods_tmp_calculation2_1' collate 'en-ci'

--end subquery

);

