--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


DELETE FROM dbp_data.l_buchungskreis_1
WHERE (
    mandant_id, system_id, buchungskreis_id) IN (
    SELECT (ADR.mandant_id, S2.system_id, ADR.buchungskreis_id)
    FROM ${TEMP_TABLE} AS ADR
    INNER JOIN dbp_data.l_system_1 AS S ON ADR.system_id = S.system_id
    INNER JOIN dbp_data.l_system_1 AS S2 ON S.system_gruppe = S2.system_gruppe
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


/* DBP_ETL.l_buchungskreis_temp */ INSERT INTO dbp_data.l_buchungskreis_1 (
    system_id, mandant_id,
    buchungskreis_id, gj_variante_id, land_id, wrg_id, kontenplan_id, buchungskreis_glob_id
)
(SELECT
    system_id,
    mandant_id,
    buchungskreis_id,
    gj_variante_id,
    land_id,
    wrg_id,
    kontenplan_id,
    buchungskreis_glob_id
FROM ${TEMP_TABLE} AS T1_1);
