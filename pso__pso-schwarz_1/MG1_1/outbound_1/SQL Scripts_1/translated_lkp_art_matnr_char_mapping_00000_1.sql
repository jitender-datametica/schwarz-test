--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL_PROCESS.ART_MATNR_CHAR_MAPPING_1' does not exist or not authorized.



SELECT MANDANT_ID,
 MATNR_CHAR,
 KL_ART_ID
FROM KFL_PRODUCTION_DBP_ETL_PROCESS.ART_MATNR_CHAR_MAPPING_1;