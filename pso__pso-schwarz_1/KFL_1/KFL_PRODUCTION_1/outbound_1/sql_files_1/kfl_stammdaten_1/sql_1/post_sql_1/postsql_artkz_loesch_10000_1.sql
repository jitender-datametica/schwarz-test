--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_DATA.artkz_loesch_1
--(
--  loesch_id,
--  mandant_id,
--  spr_id,
--  loesch_bez
--)
--SELECT
--  loesch_id,
--  mandant_id,
--  22 AS spr_id,
--  loesch_bez
--FROM DBX_LOAD.artkz_loesch_temp  t1_1
--
--WHERE NOT EXISTS
--(
--	SELECT * FROM DBX_DATA.artkz_loesch_1 t2
--	WHERE t1.loesch_id  = t2.loesch_id
--	  AND t1.mandant_id = t2.mandant_id
--	  AND t1.spr_id     = t2.spr_id
--);INSERT INTO DBX_DATA.artkz_loesch_1
--(
--  loesch_id,
--  mandant_id,
--  spr_id,
--  loesch_bez
--)
--SELECT
--  loesch_id,
--  mandant_id,
--  22 AS spr_id,
--  loesch_bez
--FROM DBX_LOAD.artkz_loesch_temp  t1_1
--
--WHERE NOT EXISTS
--(
--	SELECT * FROM DBX_DATA.artkz_loesch_1 t2
--	WHERE t1.loesch_id  = t2.loesch_id
--	  AND t1.mandant_id = t2.mandant_id
--	  AND t1.spr_id     = t2.spr_id
--);
--
--Comment from validation checker
--MESSAGE: Actual statement count 2 did not match the desired statement count 1.
--translated statement


INSERT INTO dbp_data.artkz_loesch_1 (mandant_id, loesch_id, spr_id, loesch_bez)
(SELECT
    mandant_id,
    loesch_id,
    22 AS spr_id,
    loesch_bez
FROM ${TEMP_TABLE} AS T1_1
WHERE NOT EXISTS (
    SELECT *
    FROM dbp_data.artkz_loesch_1 AS T2
    WHERE
        T1.loesch_id = loesch_id
        AND T1.mandant_id = mandant_id
        AND T1.spr_id = spr_id
));


INSERT INTO dbp_data.artkz_loesch_1 (mandant_id, loesch_id, spr_id, loesch_bez)
(SELECT
    mandant_id,
    loesch_id,
    22 AS spr_id,
    loesch_bez
FROM ${TEMP_TABLE} AS T1_1
WHERE NOT EXISTS (
    SELECT *
    FROM dbp_data.artkz_loesch_1 AS T2
    WHERE
        T1.loesch_id = loesch_id
        AND T1.mandant_id = mandant_id
        AND T1.spr_id = spr_id
));
