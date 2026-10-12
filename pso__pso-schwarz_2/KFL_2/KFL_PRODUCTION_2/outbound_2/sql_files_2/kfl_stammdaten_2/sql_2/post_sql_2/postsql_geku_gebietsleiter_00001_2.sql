--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.GEKU_GEBIETSLEITER_TEMP' does not exist or not authorized.


UPDATE dbp_data.geku_gebietsleiter_2 SET
    berichts_empfaenger_ldap = t1.`_berichts_empfaenger_ldap` FROM (SELECT
    gebietsleiter_bez AS `_gebietsleiter_bez`,
    berichts_empfaenger_ldap AS `_berichts_empfaenger_ldap`
FROM ${TEMP_TABLE}
WHERE gebietsleiter_bez IS NOT NULL) AS t1_2
WHERE geku_gebietsleiter.gebietsleiter_bez = t1.`_gebietsleiter_bez`;
