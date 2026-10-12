--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.ART_WUP_EK_DATUM_RELEVANT_KMO' does not exist or not authorized.
UPDATE DBP_ETL.art_wup_ek_datum_relevant_kmo 
SET dat_relevant = dat_relevant + 1
;

