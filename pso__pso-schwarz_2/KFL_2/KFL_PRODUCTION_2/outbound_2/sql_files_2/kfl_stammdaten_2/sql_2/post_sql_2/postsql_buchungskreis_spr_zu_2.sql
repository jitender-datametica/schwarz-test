--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


DELETE FROM dbp_data.buchungskreis_spr_zu_2
WHERE (
    mandant_id, system_id, buchungskreis_id) IN (
    SELECT (ADR.mandant_id, S2.system_id, ADR.buchungskreis_id)
    FROM ${TEMP_TABLE} AS ADR
    INNER JOIN dbp_data.l_system_2 AS S ON ADR.system_id = S.system_id
    INNER JOIN dbp_data.l_system_2 AS S2 ON S.system_gruppe = S2.system_gruppe
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


/* DBP_ETL.buchungskreis_spr_zu_temp */ INSERT INTO dbp_data.buchungskreis_spr_zu_2 (
    mandant_id,
    buchungskreis_id, spr_id, system_id, buchungskreis_bez, strasse, plz, ort
)
(SELECT
    mandant_id,
    buchungskreis_id,
    spr_id,
    system_id,
    buchungskreis_bez,
    strasse,
    plz,
    ort
FROM ${TEMP_TABLE});


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


/* DBP_ETL.buchungskreis_spr_zu_temp */ INSERT INTO dbp_data.buchungskreis_spr_zu_2 (
    mandant_id,
    buchungskreis_id, spr_id, system_id, buchungskreis_bez, strasse, plz, ort
)
(SELECT
    mandant_id,
    buchungskreis_id,
    22,
    system_id,
    buchungskreis_bez,
    strasse,
    plz,
    ort
FROM ${TEMP_TABLE}
WHERE (
    mandant_id, buchungskreis_id, 22, system_id) NOT IN (
    SELECT (mandant_id, buchungskreis_id, spr_id, system_id)
    FROM dbp_data.buchungskreis_spr_zu_2
));
