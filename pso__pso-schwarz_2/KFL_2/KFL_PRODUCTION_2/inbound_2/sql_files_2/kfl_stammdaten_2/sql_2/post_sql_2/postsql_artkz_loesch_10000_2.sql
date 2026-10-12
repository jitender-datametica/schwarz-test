--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_DATA.artkz_loesch_2
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
--FROM DBX_LOAD.artkz_loesch_temp  t1_2
--
--WHERE NOT EXISTS
--(
--	SELECT * FROM   DBX_DATA.artkz_loesch_2 t2
--	WHERE t1.loesch_id  = t2.loesch_id
--	  AND t1.mandant_id = t2.mandant_id
--	  AND t1.spr_id     = t2.spr_id
--);INSERT INTO DBX_DATA.artkz_loesch_2
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
--FROM DBX_LOAD.artkz_loesch_temp  t1_2
--
--WHERE NOT EXISTS
--(
--	SELECT * FROM   DBX_DATA.artkz_loesch_2 t2
--	WHERE t1.loesch_id  = t2.loesch_id
--	  AND t1.mandant_id = t2.mandant_id
--	  AND t1.spr_id     = t2.spr_id
--);
--
--Comment from validation checker
--MESSAGE: Actual statement count 2 did not match the desired statement count 1.
--translated statement
INSERT INTO DBP_DATA.artkz_loesch_2
(
  loesch_id,
  mandant_id,
  spr_id,
  loesch_bez
)
SELECT
  loesch_id,
  mandant_id,
  22 AS spr_id,
  loesch_bez
FROM ${TEMP_TABLE} /*DBP_ETL.artkz_loesch_temp*/  t1_2

WHERE NOT EXISTS
(
	SELECT * FROM   DBP_DATA.artkz_loesch_2 t2
	WHERE t1.loesch_id  = t2.loesch_id
	  AND t1.mandant_id = t2.mandant_id
	  AND t1.spr_id     = t2.spr_id
);
INSERT INTO DBP_DATA.artkz_loesch_2
(
  loesch_id,
  mandant_id,
  spr_id,
  loesch_bez
)
SELECT
  loesch_id,
  mandant_id,
  22 AS spr_id,
  loesch_bez
FROM ${TEMP_TABLE} /*DBP_ETL.artkz_loesch_temp*/  t1_2

WHERE NOT EXISTS
(
	SELECT * FROM   DBP_DATA.artkz_loesch_2 t2
	WHERE t1.loesch_id  = t2.loesch_id
	  AND t1.mandant_id = t2.mandant_id
	  AND t1.spr_id     = t2.spr_id
);

