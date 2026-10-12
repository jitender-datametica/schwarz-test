--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


/* DBP_ETL.l_lagerort_temp */ INSERT INTO dbp_data.l_lagerort_2 (
    mandant_id, lagerort_id, wup_id, nb_id,
    lagernummer_id
)
(
    SELECT
        mandant_id,
        '' AS lagerort_id,
        wup_id,
        nb_id,
        ''
    FROM ${TEMP_TABLE} AS T1_2
    WHERE
        nb_id IN (99, -111)
        AND (
            mandant_id, lagerort_id, wup_id) NOT IN (
            SELECT (mandant_id, lagerort_id, wup_id)
            FROM dbp_data.l_lagerort_2 AS T2
            WHERE nb_id IN (99, -111)
        )
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


/* DBP_ETL.l_lagerort_temp */ INSERT INTO dbp_data.l_lagerort_2 (
    mandant_id, lagerort_id, wup_id, nb_id,
    lagernummer_id
)
(
    SELECT
        mandant_id,
        '-1' AS lagerort_id,
        wup_id,
        nb_id,
        ''
    FROM ${TEMP_TABLE} AS T1_2
    WHERE
        nb_id IN (99, -111)
        AND (
            mandant_id, lagerort_id, wup_id) NOT IN (
            SELECT (mandant_id, lagerort_id, wup_id)
            FROM dbp_data.l_lagerort_2 AS T2
            WHERE nb_id IN (99, -111)
        )
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


/* DBP_ETL.l_lagerort_temp */ INSERT INTO dbp_data.l_lagerort_2 (
    mandant_id, lagerort_id, wup_id, nb_id,
    lagernummer_id
)
(
    SELECT
        mandant_id,
        '-2' AS lagerort_id,
        wup_id,
        nb_id,
        ''
    FROM ${TEMP_TABLE} AS T1_2
    WHERE
        nb_id IN (99, -111)
        AND (
            mandant_id, lagerort_id, wup_id) NOT IN (
            SELECT (mandant_id, lagerort_id, wup_id)
            FROM dbp_data.l_lagerort_2 AS T2
            WHERE nb_id IN (99, -111)
        )
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


/* DBP_ETL.l_lagerort_temp */ INSERT INTO dbp_data.l_lagerort_2 (
    mandant_id, lagerort_id, wup_id, nb_id,
    lagernummer_id
)
(
    SELECT
        mandant_id,
        '-3' AS lagerort_id,
        wup_id,
        nb_id,
        ''
    FROM ${TEMP_TABLE} AS T1_2
    WHERE
        nb_id IN (99, -111)
        AND (
            mandant_id, lagerort_id, wup_id) NOT IN (
            SELECT (mandant_id, lagerort_id, wup_id)
            FROM dbp_data.l_lagerort_2 AS T2
            WHERE nb_id IN (99, -111)
        )
);
