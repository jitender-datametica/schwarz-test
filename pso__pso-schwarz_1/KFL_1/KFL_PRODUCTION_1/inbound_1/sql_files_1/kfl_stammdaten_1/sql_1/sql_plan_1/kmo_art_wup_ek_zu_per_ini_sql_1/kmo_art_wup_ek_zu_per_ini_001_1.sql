
SELECT COUNT(*) FROM (

--begin subquery
SELECT table_name FROM information_schema.tables
WHERE UPPER(table_name) = 'KMO_ART_WUP_EK_DATUM_RELEVANT_1'
AND UPPER(table_schema) = UPPER('DBP_ETL_1')
--end subquery

);

