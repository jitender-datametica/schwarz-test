--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


/* DBP_ETL.wug_temp */ INSERT INTO dbp_data.wug (wug_id, wg_id, arthiertyp_id, mandant_id)
(SELECT
    wug_id,
    wg_id,
    arthiertyp_id,
    mandant_id
FROM ${TEMP_TABLE} AS T1
WHERE NOT EXISTS (
    SELECT *
    FROM dbp_data.wug AS T2
    WHERE
        T1.wug_id = wug_id
        AND T1.wg_id = wg_id
        AND T1.arthiertyp_id = arthiertyp_id
        AND T1.mandant_id = mandant_id
));


DELETE FROM dbp_data.wug
WHERE wug_id = -9;
