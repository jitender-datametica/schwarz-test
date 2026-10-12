--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO DBP_DATA.wug_spr_zu
(
     arthiertyp_id
    ,mandant_id
    ,wg_id
    ,spr_id
    ,wug_id
    ,wug_bez
)
SELECT
     arthiertyp_id
    ,mandant_id
    ,wg_id
    ,spr_id
    ,wug_id
    ,wug_bez
FROM ${TEMP_TABLE} /*DBP_ETL.wug_spr_zu_temp*/ t1
WHERE NOT EXISTS (SELECT * FROM DBP_DATA.wug_spr_zu t2
WHERE
     t1.arthiertyp_id             = t2.arthiertyp_id
   AND t1.mandant_id                = t2.mandant_id
   AND t1.wg_id                     = t2.wg_id
   AND t1.spr_id                    = t2.spr_id
   AND t1.wug_id                    = t2.wug_id
);

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_DATA.wug_spr_zu
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
--FROM DBX_LOAD.wug_spr_zu_temp  t1
--
--WHERE NOT EXISTS
--(
--SELECT  * FROM   DBX_DATA.wug_spr_zu t2
--WHERE t1.arthiertyp_id = t2.arthiertyp_id
--  AND   t1.mandant_id  = t2.mandant_id
--  AND   t1.wg_id       = t2.wg_id
--  AND   t1.spr_id      = t2.spr_id
--  AND   t1.wug_id      = t2.wug_id
--);INSERT INTO DBX_DATA.wug_spr_zu
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
--FROM DBX_LOAD.wug_spr_zu_temp t1
--WHERE NOT EXISTS (SELECT * FROM DBX_DATA.wug_spr_zu t2
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
INSERT INTO DBP_DATA.wug_spr_zu
(
  arthiertyp_id,
  mandant_id,
  wg_id,
  spr_id,
  wug_id,
  wug_bez
)
SELECT
  arthiertyp_id,
  mandant_id,
  wg_id,
  22 as spr_id,
  wug_id,
  wug_bez
FROM ${TEMP_TABLE} /*DBP_ETL.wug_spr_zu_temp*/  t1

WHERE NOT EXISTS
(
SELECT  * FROM   DBP_DATA.wug_spr_zu t2
WHERE t1.arthiertyp_id = t2.arthiertyp_id
  AND   t1.mandant_id  = t2.mandant_id
  AND   t1.wg_id       = t2.wg_id
  AND   t1.spr_id      = t2.spr_id
  AND   t1.wug_id      = t2.wug_id
);INSERT INTO DBP_DATA.wug_spr_zu
(
     arthiertyp_id
    ,mandant_id
    ,wg_id
    ,spr_id
    ,wug_id
    ,wug_bez
)
SELECT
     arthiertyp_id
    ,mandant_id
    ,wg_id
    ,spr_id
    ,wug_id
    ,wug_bez
FROM ${TEMP_TABLE} /*DBP_ETL.wug_spr_zu_temp*/ t1
WHERE NOT EXISTS (SELECT * FROM DBP_DATA.wug_spr_zu t2
WHERE
     t1.arthiertyp_id             = t2.arthiertyp_id
   AND t1.mandant_id                = t2.mandant_id
   AND t1.wg_id                     = t2.wg_id
   AND t1.spr_id                    = t2.spr_id
   AND t1.wug_id                    = t2.wug_id
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO DBP_DATA.wug_spr_zu
(
  arthiertyp_id,
  mandant_id,
  wg_id,
  spr_id,
  wug_id,
  wug_bez
)
SELECT
  arthiertyp_id,
  mandant_id,
  wg_id,
  22 as spr_id,
  wug_id,
  wug_bez
FROM ${TEMP_TABLE} /*DBP_ETL.wug_spr_zu_temp*/  t1

WHERE NOT EXISTS
(
SELECT  * FROM   DBP_DATA.wug_spr_zu t2
WHERE t1.arthiertyp_id = t2.arthiertyp_id
  AND   t1.mandant_id  = t2.mandant_id
  AND   t1.wg_id       = t2.wg_id
  AND   t1.spr_id      = t2.spr_id
  AND   t1.wug_id      = t2.wug_id
);

delete from dbp_data.wug_spr_zu
where wug_id = -9
;
