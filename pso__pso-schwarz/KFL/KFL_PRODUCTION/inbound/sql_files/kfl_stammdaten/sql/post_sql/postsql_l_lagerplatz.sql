--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--DELETE FROM DBP_DATA.l_lagernummer
--WHERE ( mandant_id, lagernummer_id)  IN
--(SELECT mandant_id, lagernummer_id
--FROM   ${TEMP_TABLE} /*DBP_ETL.l_lagerplatz_temp*/
--)
--;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : CSUM is Teradata analytical function that is not supported by Snowflake. It needs to be replaced with: SUM(expr1) OVER (PARTITION BY expr2 ORDER BY expr3 ROWS UNBOUNDED PRECEDING). QUALIFY CSUM(1, expr) is probably equivalent of ROW_NUMBER.
--original statement
--INSERT DBX_DATA.l_lagernummer
--(
--  mandant_id
--, lagernummer_id
--, wup_id
--, nb_id
--, oug_fg
--)
--SELECT
--mandant_id
--, lagernummer_id
--, wup_id
--, nb_id
--,oug_fg
--FROM (
-- SELECT
--   mandant_id
-- , lagernummer_id
-- , wup_id
-- , nb_id
-- ,SUBSTR(lagernummer_id,LENGTH(lagernummer_id),1) AS lagernr_id
-- ,CASE WHEN lagernr_id = '6' AND mandant_id =1 THEN 1
-- WHEN lagernr_id = '2' AND mandant_id <> 1 THEN 1
-- ELSE 0 END as oug_fg
-- FROM  DBX_LOAD.l_lagerplatz_temp
-- GROUP BY mandant_id, lagernummer_id
-- QUALIFY CSUM(1, wup_id DESC, nb_id DESC) = 1
-- ) s
--;
--
--Comment from validation checker
--error line 27 at position 24 unexpected 'DESC'.
--syntax error line 27 at position 40 unexpected ')'.
--translated statement
--INSERT INTO DBP_DATA.l_lagernummer
--(
--  mandant_id
--, lagernummer_id
--, wup_id
--, nb_id
--, oug_fg
--, td_insert
--, td_update
--)
--SELECT
--mandant_id
--, lagernummer_id
--, wup_id
--, nb_id
--, oug_fg
--, td_insert
--, td_update
--FROM (
-- SELECT
--   mandant_id
-- , lagernummer_id
-- , wup_id
-- , nb_id
-- ,SUBSTR(lagernummer_id,LENGTH(lagernummer_id),1) AS lagernr_id
-- ,CASE WHEN lagernr_id = '6' AND mandant_id =1 THEN 1
-- WHEN lagernr_id = '2' AND mandant_id <> 1 THEN 1
-- ELSE 0 END as oug_fg
-- , td_insert
-- , td_update
-- FROM ${TEMP_TABLE} /* DBP_ETL.l_lagerplatz_temp*/
 /*GROUP BY mandant_id, lagernummer_id*/
/* QUALIFY  CSUM(1, wup_id DESC, nb_id DESC) = 1*/
--mfialkiewicz
--QUALIFY row_number() OVER (PARTITION BY mandant_id, lagernummer_id order by wup_id DESC, nb_id DESC) = 1
-- ) s
--;

MERGE INTO DBP_DATA.l_lagernummer l
USING (
  SELECT
  mandant_id,
  lagernummer_id,
  wup_id,
  nb_id,
  oug_fg,
  td_insert,
  td_update
  FROM (
    SELECT
    mandant_id,
    lagernummer_id,
    wup_id,
    nb_id,
    SUBSTR(lagernummer_id,LENGTH(lagernummer_id),1) AS lagernr_id,
    CASE WHEN lagernr_id = '6' AND mandant_id =1 THEN 1
         WHEN lagernr_id = '2' AND mandant_id <> 1 THEN 1
    ELSE 0 END as oug_fg,
    td_insert,
    td_update
    FROM ${TEMP_TABLE}
    QUALIFY row_number() OVER (PARTITION BY mandant_id, lagernummer_id order by wup_id DESC, nb_id DESC) = 1
    ) ss
) s
ON l.mandant_id = s.mandant_id AND l.lagernummer_id = s.lagernummer_id
WHEN MATCHED THEN
  UPDATE SET l.wup_id = s.wup_id, l.nb_id = s.nb_id, l.oug_fg = s.oug_fg, l.td_insert = s.td_insert, l.td_update = s.td_update  
  WHEN NOT MATCHED THEN
  INSERT (mandant_id, lagernummer_id, wup_id, nb_id, oug_fg, td_insert, td_update) 
  VALUES (s.mandant_id, s.lagernummer_id, s.wup_id, s.nb_id, s.oug_fg, s.td_insert, s.td_update);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
DELETE FROM DBP_DATA.l_lagertyp
WHERE ( mandant_id, lagernummer_id, lagertyp_id)  IN
(SELECT mandant_id, lagernummer_id, lagertyp_id
FROM ${TEMP_TABLE} /*DBP_ETL.l_lagerplatz_temp*/
)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : CSUM is Teradata analytical function that is not supported by Snowflake. It needs to be replaced with: SUM(expr1) OVER (PARTITION BY expr2 ORDER BY expr3 ROWS UNBOUNDED PRECEDING). QUALIFY CSUM(1, expr) is probably equivalent of ROW_NUMBER.
--original statement
--INSERT DBX_DATA.l_lagertyp
--(
--mandant_id
--, lagernummer_id
--, lagertyp_id
--
--, wup_id
--, nb_id
--, lagerzone_id
--, lagertyp_typ_id
--, griffzone_typ_id
--)
--SELECT
--mandant_id
--, lagernummer_id
--, lagertyp_id
--, wup_id
--, nb_id
--,CAST('' AS varchar(1)) as lagerzone_id
--, lagertyp_typ_id
--,  griffzone_typ_id
--FROM
--(
--SELECT
--t0.*
--,CASE
--WHEN lagertyp_id = 'G09' AND mandant_id = 1 THEN ''
--WHEN SUBSTR(TRIM(lagertyp_id),1,2) IN  ('G0', 'G1', 'G2', 'G3', 'G4', 'G5', 'G6', 'G7', 'G8', 'G9', 'GT', 'GH') THEN  'G'
--WHEN SUBSTR(TRIM(lagertyp_id),1,2) IN  ('R0', 'R1', 'R2', 'R3', 'R4', 'R5', 'R6', 'R7', 'R8', 'R9', 'RT', 'RH') THEN  'R'
--WHEN SUBSTR(TRIM(lagertyp_id),1,2) IN  ('H0', 'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9') THEN  'H'
--WHEN lagertyp_id like 'B%' THEN 'B'
--ELSE ' '
--END  AS lagertyp_typ_id
--,CASE WHEN lagertyp_typ_id ='G' THEN 
--	CASE WHEN lagertyp_id IN ('G01','G03','G06','G13','G23','GH1') 
--							OR (mandant_id in (1,2) AND  lagertyp_id IN ('G33')) THEN '1'
--	ELSE '2'
--	END
--END AS griffzone_typ_id
--FROM DBX_LOAD.l_lagerplatz_temp t0
--)dt1
--GROUP BY  mandant_id, lagernummer_id, lagertyp_id
--QUALIFY CSUM(1, wup_id DESC, nb_id DESC) = 1
--;
--
--Comment from validation checker
--error line 43 at position 23 unexpected 'DESC'.
--syntax error line 43 at position 35 unexpected 'DESC'.
--translated statement
INSERT INTO DBP_DATA.l_lagertyp
(
mandant_id
, lagernummer_id
, lagertyp_id

, wup_id
, nb_id
, lagerzone_id
, lagertyp_typ_id
, griffzone_typ_id
)
SELECT
mandant_id
, lagernummer_id
, lagertyp_id
, wup_id
, nb_id
,CAST('' AS varchar(1)) as lagerzone_id
, lagertyp_typ_id
,  griffzone_typ_id
FROM
(
SELECT
t0.*
,CASE
WHEN lagertyp_id = 'G09' AND mandant_id = 1 THEN ''
WHEN SUBSTR(TRIM(lagertyp_id),1,2) IN  ('G0', 'G1', 'G2', 'G3', 'G4', 'G5', 'G6', 'G7', 'G8', 'G9', 'GT', 'GH') THEN  'G'
WHEN SUBSTR(TRIM(lagertyp_id),1,2) IN  ('R0', 'R1', 'R2', 'R3', 'R4', 'R5', 'R6', 'R7', 'R8', 'R9', 'RT', 'RH') THEN  'R'
WHEN SUBSTR(TRIM(lagertyp_id),1,2) IN  ('H0', 'H1', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9') THEN  'H'
WHEN lagertyp_id like 'B%' THEN 'B'
ELSE ' '
END  AS lagertyp_typ_id
,CASE WHEN lagertyp_typ_id ='G' THEN 
	CASE WHEN lagertyp_id IN ('G01','G03','G06','G13','G23','GH1') 
		OR (mandant_id in (1,2) AND  lagertyp_id IN ('G33')) THEN '1'
	ELSE '2'
	END
END AS griffzone_typ_id
FROM ${TEMP_TABLE} /*DBP_ETL.l_lagerplatz_temp*/ t0
)dt1
/*GROUP BY  mandant_id, lagernummer_id, lagertyp_id
QUALIFY CSUM(1, wup_id DESC, nb_id DESC) = 1*/
--mfialkiewicz
QUALIFY row_number() OVER (PARTITION BY mandant_id, lagernummer_id, lagertyp_id order by wup_id DESC, nb_id DESC) = 1
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
DELETE FROM DBP_DATA.l_lagerbereich
WHERE ( mandant_id, lagernummer_id, lagertyp_id, lagerbereich_id)  IN
(SELECT mandant_id, lagernummer_id, lagertyp_id, lagerbereich_id
FROM ${TEMP_TABLE} /* DBP_ETL.l_lagerplatz_temp*/
)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : CSUM is Teradata analytical function that is not supported by Snowflake. It needs to be replaced with: SUM(expr1) OVER (PARTITION BY expr2 ORDER BY expr3 ROWS UNBOUNDED PRECEDING). QUALIFY CSUM(1, expr) is probably equivalent of ROW_NUMBER.
--original statement
--INSERT DBX_DATA.l_lagerbereich
--(
--mandant_id
--, lagernummer_id
--, lagertyp_id
--, lagerbereich_id
--
--, wup_id
--, nb_id
--)
--SELECT
--mandant_id
--, lagernummer_id
--, lagertyp_id
--, lagerbereich_id
--
--, wup_id
--, nb_id
--
--FROM DBX_LOAD.l_lagerplatz_temp
--WHERE lagerbereich_id IS NOT NULL
--GROUP BY  mandant_id, lagernummer_id, lagertyp_id, lagerbereich_id
--QUALIFY CSUM(1, wup_id DESC, nb_id DESC) = 1
--;
--
--Comment from validation checker
--error line 23 at position 23 unexpected 'DESC'.
--syntax error line 23 at position 35 unexpected 'DESC'.
--translated statement
INSERT INTO DBP_DATA.l_lagerbereich
(
mandant_id
, lagernummer_id
, lagertyp_id
, lagerbereich_id

, wup_id
, nb_id
)
SELECT
mandant_id
, lagernummer_id
, lagertyp_id
, lagerbereich_id
, wup_id
, nb_id
FROM ${TEMP_TABLE} /*DBP_ETL.l_lagerplatz_temp*/
WHERE lagerbereich_id IS NOT NULL
/*GROUP BY  mandant_id, lagernummer_id, lagertyp_id, lagerbereich_id
QUALIFY CSUM(1, wup_id DESC, nb_id DESC) = 1*/
--mfialkiewicz
QUALIFY row_number() OVER (PARTITION BY mandant_id, lagernummer_id, lagertyp_id, lagerbereich_id order by wup_id DESC, nb_id DESC) = 1
;

DELETE FROM DBP_DATA.l_lagerplatz
WHERE lagernummer_id = 'B11'AND
      mandant_id = 8 AND
      lagertyp_id = 'EA2'
;
