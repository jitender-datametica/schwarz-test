--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL_PROCESS.ART_MATNR_CHAR_MAPPING_2' does not exist or not authorized.
select mandant_id, matnr_char, kl_art_id FROM DBP_ETL_PROCESS.art_matnr_char_mapping_2;

