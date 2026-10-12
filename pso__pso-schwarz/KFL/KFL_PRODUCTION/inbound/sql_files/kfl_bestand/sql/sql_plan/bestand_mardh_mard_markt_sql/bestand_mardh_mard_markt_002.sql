--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.BESTAND_MARDH_MARD_LOG' does not exist or not authorized.
SELECT COUNT(*) FROM (

--begin subquery
SELECT mandant_id, COUNT(*)
FROM DBP_ETL.bestand_mardh_mard_log
GROUP BY 1

--end subquery

);

