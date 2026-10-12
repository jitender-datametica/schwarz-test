--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.GEKU_GEBIETSLEITER_TEMP' does not exist or not authorized.
UPDATE DBP_DATA.geku_gebietsleiter 
SET
     berichts_empfaenger_ldap  = _berichts_empfaenger_ldap
FROM
(SELECT
     gebietsleiter_bez         as _gebietsleiter_bez
    ,berichts_empfaenger_ldap  as _berichts_empfaenger_ldap
FROM ${TEMP_TABLE} /*DBP_ETL.geku_gebietsleiter_temp*/ where gebietsleiter_bez is not null) t1 WHERE
     gebietsleiter_bez         = _gebietsleiter_bez
;

