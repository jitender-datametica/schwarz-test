--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.KMO_EKPO_1' does not exist or not authorized.
SELECT COUNT(*) FROM (

--begin subquery
SELECT mandant_id FROM DBP_ETL.kmo_ekpo_1 LIMIT 1

--end subquery

);

