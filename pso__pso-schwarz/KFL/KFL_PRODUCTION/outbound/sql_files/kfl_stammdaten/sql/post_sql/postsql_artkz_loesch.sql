--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


/* DBP_ETL.artkz_loesch_temp */ INSERT INTO dbp_data.artkz_loesch (
    mandant_id, loesch_id, spr_id,
    loesch_bez
)
(SELECT DISTINCT
    mandant_id,
    loesch_id,
    22 AS spr_id,
    loesch_bez
FROM ${TEMP_TABLE} AS T1
WHERE (
    loesch_id, mandant_id, 1) NOT IN (
    SELECT (loesch_id, mandant_id, a1216544270)
    FROM (SELECT
        mandant_id,
        loesch_id,
        COUNT(spr_id) AS a1216544270
    FROM dbp_data.artkz_loesch AS T3
    WHERE spr_id = 22
    GROUP BY
        mandant_id,
        loesch_id
    HAVING a1216544270 = 1) AS t2
));
