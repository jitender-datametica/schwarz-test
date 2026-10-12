--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.ART_WUP_EK_DATUM_RELEVANT_KMO' does not exist or not authorized.


UPDATE dbp_etl.art_wup_ek_datum_relevant_kmo SET
    dat_relevant
    = DATE_ADD(art_wup_ek_datum_relevant_kmo.dat_relevant, INTERVAL 1 DAY)
WHERE TRUE;
