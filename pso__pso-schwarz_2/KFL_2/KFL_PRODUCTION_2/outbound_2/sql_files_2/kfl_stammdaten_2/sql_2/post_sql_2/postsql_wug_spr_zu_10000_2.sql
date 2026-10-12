--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


/* DBP_ETL.wug_spr_zu_temp_2 */ INSERT INTO dbp_data.wug_spr_zu_2 (
    arthiertyp_id, mandant_id, wg_id, spr_id,
    wug_id, wug_bez
)
(SELECT
    arthiertyp_id,
    mandant_id,
    wg_id,
    spr_id,
    wug_id,
    wug_bez
FROM ${TEMP_TABLE} AS T1_2
WHERE NOT EXISTS (
    SELECT *
    FROM dbp_data.wug_spr_zu_2 AS T2
    WHERE
        T1.arthiertyp_id = arthiertyp_id
        AND T1.mandant_id = mandant_id
        AND T1.wg_id = wg_id
        AND T1.spr_id = spr_id
        AND T1.wug_id = wug_id
));


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_DATA.wug_spr_zu_2
--(
--  arthiertyp_id,
--  mandant_id,
--  wg_id,
--  spr_id,
--  wug_id,
--  wug_bez
--)
--SELECT
--  arthiertyp_id,
--  mandant_id,
--  wg_id,
--  22 as spr_id,
--  wug_id,
--  wug_bez
--FROM DBX_LOAD.wug_spr_zu_temp_2  t1_2
--
--WHERE NOT EXISTS
--(
--SELECT  * FROM DBX_DATA.wug_spr_zu_2 t2
--WHERE t1.arthiertyp_id = t2.arthiertyp_id
--  AND   t1.mandant_id  = t2.mandant_id
--  AND   t1.wg_id       = t2.wg_id
--  AND   t1.spr_id      = t2.spr_id
--  AND   t1.wug_id      = t2.wug_id
--);INSERT INTO DBX_DATA.wug_spr_zu_2
--(
--     arthiertyp_id
--    ,mandant_id
--    ,wg_id
--    ,spr_id
--    ,wug_id
--    ,wug_bez
--)
--SELECT
--     arthiertyp_id
--    ,mandant_id
--    ,wg_id
--    ,spr_id
--    ,wug_id
--    ,wug_bez
--FROM DBX_LOAD.wug_spr_zu_temp_2 t1_2
--WHERE NOT EXISTS (SELECT * FROM DBX_DATA.wug_spr_zu_2 t2
--WHERE
--     t1.arthiertyp_id             = t2.arthiertyp_id
--   AND t1.mandant_id                = t2.mandant_id
--   AND t1.wg_id                     = t2.wg_id
--   AND t1.spr_id                    = t2.spr_id
--   AND t1.wug_id                    = t2.wug_id
--);
--
--Comment from validation checker
--MESSAGE: Actual statement count 2 did not match the desired statement count 1.
--translated statement


/* DBP_ETL.wug_spr_zu_temp_2 */ INSERT INTO dbp_data.wug_spr_zu_2 (
    arthiertyp_id, mandant_id, wg_id, spr_id,
    wug_id, wug_bez
)
(SELECT
    arthiertyp_id,
    mandant_id,
    wg_id,
    22 AS spr_id,
    wug_id,
    wug_bez
FROM ${TEMP_TABLE} AS T1_2
WHERE NOT EXISTS (
    SELECT *
    FROM dbp_data.wug_spr_zu_2 AS T2
    WHERE
        T1.arthiertyp_id = arthiertyp_id
        AND T1.mandant_id = mandant_id
        AND T1.wg_id = wg_id
        AND T1.spr_id = spr_id
        AND T1.wug_id = wug_id
));


/* DBP_ETL.wug_spr_zu_temp_2 */ INSERT INTO dbp_data.wug_spr_zu_2 (
    arthiertyp_id, mandant_id, wg_id, spr_id,
    wug_id, wug_bez
)
(SELECT
    arthiertyp_id,
    mandant_id,
    wg_id,
    spr_id,
    wug_id,
    wug_bez
FROM ${TEMP_TABLE} AS T1_2
WHERE NOT EXISTS (
    SELECT *
    FROM dbp_data.wug_spr_zu_2 AS T2
    WHERE
        T1.arthiertyp_id = arthiertyp_id
        AND T1.mandant_id = mandant_id
        AND T1.wg_id = wg_id
        AND T1.spr_id = spr_id
        AND T1.wug_id = wug_id
));


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


/* DBP_ETL.wug_spr_zu_temp_2 */ INSERT INTO dbp_data.wug_spr_zu_2 (
    arthiertyp_id, mandant_id, wg_id, spr_id,
    wug_id, wug_bez
)
(SELECT
    arthiertyp_id,
    mandant_id,
    wg_id,
    22 AS spr_id,
    wug_id,
    wug_bez
FROM ${TEMP_TABLE} AS T1_2
WHERE NOT EXISTS (
    SELECT *
    FROM dbp_data.wug_spr_zu_2 AS T2
    WHERE
        T1.arthiertyp_id = arthiertyp_id
        AND T1.mandant_id = mandant_id
        AND T1.wg_id = wg_id
        AND T1.spr_id = spr_id
        AND T1.wug_id = wug_id
));


DELETE FROM dbp_data.wug_spr_zu_2
WHERE wug_id = -9;
