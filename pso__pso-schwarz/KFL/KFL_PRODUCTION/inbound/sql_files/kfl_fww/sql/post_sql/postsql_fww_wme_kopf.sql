--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.aktionsart_spr_zu 
WHERE(mandant_id, aktionsart_id) 
IN(SELECT 1, aktionsart  FROM DBP_ETL.fww_wme_kopf )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.l_aktionsart
(
  mandant_id
, aktionsart_id
)
SELECT DISTINCT
  1 AS MANDT
, aktionsart
FROM DBP_ETL.fww_wme_kopf
WHERE  aktionsart 
NOT IN
( SELECT DISTINCT
    aktionsart_id
  FROM DBP_DATA.l_aktionsart
  WHERE mandant_id = 1
);

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.aktionsart_spr_zu
(
  mandant_id
, aktionsart_id
, spr_id
, aktionsart_bez
)
SELECT DISTINCT 
  1 as mandant_id
, a.aktionsart_id
, a.spr_id
, CASE WHEN a.aktionsart_bez IS NULL
       THEN default_text.aktionsart_bez
       ELSE a.aktionsart_bez 
    END AS aktionsart_bez
FROM
  (
    SELECT
      k.mandant_id as mandant_id
    , k.spr_id
    , k.aktionsart_id
    , w.aktionsart_bez
    FROM
    (
      SELECT
        1       AS mandant_id
      , spr_id     AS spr_id
      , aktionsart AS aktionsart_id
      FROM
        DBP_ETL.fww_wme_kopf src,
        DBP_DATA.spr spr
      WHERE
        spr.dwh_spr = 1
      GROUP BY 1,2,3
    ) k
    LEFT OUTER JOIN
    (
      SELECT
        1           AS mandant_id
      , dwhspr.spr_id  AS org_spr_id
      , aktionsart     AS aktionsart_id
      , aktionsart_bez AS aktionsart_bez
      FROM
        DBP_ETL.fww_wme_kopf dt1
      INNER JOIN
      ( SELECT
          spr_id
        , sap_spr_id
        FROM DBP_DATA.sap_dwh_spr_zu
        WHERE mandant_id = 1
      ) dwhspr
      ON dt1.SPRAS = dwhspr.sap_spr_id
    ) w
      ON k.mandant_id     = w.mandant_id
      AND k.spr_id        = w.org_spr_id
      AND k.aktionsart_id = w.aktionsart_id
  ) a
INNER JOIN
(
SELECT
     1 AS mandant_id
    ,SPRAS AS sap_spr_id
    ,aktionsart AS aktionsart_id
    ,aktionsart_bez AS aktionsart_bez
  FROM 
  DBP_ETL.fww_wme_kopf
  WHERE 
    SPRAS = 'D'
  ) default_text
  ON
  a.mandant_id = default_text.mandant_id
  AND
  a.aktionsart_id = default_text.aktionsart_id
  
  
  
WHERE (1, a.aktionsart_id, a.spr_id)
NOT IN
( SELECT
    mandant_id, aktionsart_id, spr_id
  FROM DBP_DATA.aktionsart_spr_zu
  WHERE mandant_id = 1
)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_LOAD.fww_wme_kopf_tmp
--(
--mandant_id,
--sap_werbe_kat_id,
--werbe_kat_id,
--werbekategorie_bez,
--SPRAS,
--cycle_id
-- )
--
--SELECT
-- mandant_id
--,sap_werbe_kat_id
--,werbe_kat_id + COALESCE(max_werbe_kat_id,0) werbe_kat_id
--,substring(werbekategorie_bez from 1 for 40)
--,spras
--
--FROM
--
--(
--SELECT
-- mandant_id
--,sap_werbe_kat_id
--,ROW_NUMBER () OVER (PARTITION BY 1 ORDER BY werbe_kat_id) AS werbe_kat_id 
--,werbekategorie_bez
--,spras
--
--FROM
--(
--SELECT  DISTINCT 
--1 AS mandant_id,
--TRIM(BOTH FROM dt1.werbekategorie) AS sap_werbe_kat_id,
--dt2.werbe_kat_id AS werbe_kat_id ,
--TRIM(BOTH FROM dt1.werbekategorie_bez) AS werbekategorie_bez,              
--'D' AS SPRAS
--
--FROM 
--  DBX_LOAD.fww_wme_kopf dt1
--LEFT OUTER JOIN 
--(
--
--SELECT  
--a.mandant_id        AS  mandant_id,
--a.sap_werbe_kat_id  AS sap_werbe_kat_id,
--b.werbe_kat_bez,
--a.werbe_kat_id
--
--FROM  DBX_DATA.l_werbekat a
--INNER JOIN  DBX_DATA.werbekat_spr_zu b
--ON  a.mandant_id = b.mandant_id
--AND a.werbe_kat_id = b.werbe_kat_id
--
--GROUP  BY  1,2,3,4 
--) dt2
--ON  TRIM (BOTH FROM dt1.werbekategorie) = dt2.sap_werbe_kat_id
--AND TRIM(BOTH FROM dt2.werbe_kat_bez) = TRIM(BOTH FROM dt1.werbekategorie_bez)
--
--WHERE 
-- ( dt1.werbekategorie_bez, TRIM(BOTH FROM dt1.werbekategorie))
--NOT IN
--(SELECT  
--  dt1.werbe_kat_bez
--, dt2.sap_werbe_kat_id
--FROM DBX_DATA.werbekat_spr_zu dt1
--INNER JOIN DBX_DATA.l_werbekat dt2
--ON CAST(dt1.werbe_kat_id AS INTEGER) = dt2.werbe_kat_id
--)
--)dt3
--)dt4
--
--LEFT OUTER JOIN
--(SELECT
--MAX(werbe_kat_id) AS max_werbe_kat_id
--FROM DBX_DATA.l_werbekat
--)dt5
--
--ON 1=1
--
--;
--
--Comment from validation checker
--MESSAGE: SQL compilation error:
--Insert value list does not match column list expecting 6 but got 5
--translated statement
INSERT INTO DBP_ETL.fww_wme_kopf_tmp
(
mandant_id,
sap_werbe_kat_id,
werbe_kat_id,
werbekategorie_bez,
SPRAS,
cycle_id
 )

SELECT
 mandant_id
,sap_werbe_kat_id
,werbe_kat_id + COALESCE(max_werbe_kat_id,0) werbe_kat_id
,substring(werbekategorie_bez, 1, 40)
,spras

FROM

(
SELECT
 mandant_id
,sap_werbe_kat_id
,ROW_NUMBER () OVER (PARTITION BY 1 ORDER BY werbe_kat_id) AS werbe_kat_id 
,werbekategorie_bez
,spras

FROM
(
SELECT  DISTINCT 
1 AS mandant_id,
TRIM(dt1.werbekategorie) AS sap_werbe_kat_id,
dt2.werbe_kat_id AS werbe_kat_id ,
TRIM(dt1.werbekategorie_bez) AS werbekategorie_bez,              
'D' AS SPRAS

FROM 
  DBP_ETL.fww_wme_kopf dt1
LEFT OUTER JOIN 
(

SELECT  
a.mandant_id        AS  mandant_id,
a.sap_werbe_kat_id  AS sap_werbe_kat_id,
b.werbe_kat_bez,
a.werbe_kat_id

FROM  DBP_DATA.l_werbekat a
INNER JOIN  DBP_DATA.werbekat_spr_zu b
ON  a.mandant_id = b.mandant_id
AND a.werbe_kat_id = b.werbe_kat_id

GROUP  BY  1,2,3,4 
) dt2
ON  TRIM (dt1.werbekategorie) = dt2.sap_werbe_kat_id
AND TRIM(dt2.werbe_kat_bez) = TRIM(dt1.werbekategorie_bez)

WHERE 
 ( dt1.werbekategorie_bez, TRIM(dt1.werbekategorie))
NOT IN
(SELECT  
  dt1.werbe_kat_bez
, dt2.sap_werbe_kat_id
FROM DBP_DATA.werbekat_spr_zu dt1
INNER JOIN DBP_DATA.l_werbekat dt2
ON CAST(dt1.werbe_kat_id AS INTEGER) = dt2.werbe_kat_id
)
)dt3
)dt4

LEFT OUTER JOIN
(SELECT
MAX(werbe_kat_id) AS max_werbe_kat_id
FROM DBP_DATA.l_werbekat
)dt5

ON 1=1

;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.l_werbekat
(
  mandant_id
, werbe_kat_id
, sap_werbe_kat_id
)
SELECT DISTINCT
  mandant_id
, CAST(werbe_kat_id AS INTEGER )
, sap_werbe_kat_id
FROM 
DBP_ETL.fww_wme_kopf_tmp
WHERE
(mandant_id, werbe_kat_id, sap_werbe_kat_id)
NOT IN
(SELECT
mandant_id, werbe_kat_id, sap_werbe_kat_id
FROM
DBP_DATA.l_werbekat
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.werbekat_spr_zu
(
     mandant_id
   , werbe_kat_id
   , spr_id
   , werbe_kat_bez   
)
SELECT
     mandant_id AS mandant_id
   , werbe_kat_id AS werbe_kat_id
   , s.spr_id AS spr_id
   , CASE  WHEN  werbekategorie_bez = '' THEN  'system generated' ELSE  TRIM(werbekategorie_bez) END  AS werbe_kat_bez
 
FROM DBP_DATA.spr s, DBP_ETL.fww_wme_kopf_tmp 

WHERE s.dwh_spr = 1  
AND (1, werbe_kat_id, spr_id)
NOT IN
( SELECT
    mandant_id, werbe_kat_id, spr_id
  FROM DBP_DATA.werbekat_spr_zu
  WHERE mandant_id = 1
)

GROUP BY 1,2,3,4
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.FWW_WME_KOPF' does not exist or not authorized.
DELETE FROM DBP_DATA.aktion
WHERE (
       mandant_id,
       aktion_id
       )
IN 
(SELECT
  1 AS mandant_id
, aktionsnummer 
 FROM DBP_ETL.fww_wme_kopf
)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--INSERT INTO DBX_DATA.aktion  
--(  
--       mandant_id  
--      ,aktion_id
--      ,bewart_id
--      ,aktionsart_id
--      ,werbe_kat_id
--      ,dat_von
--      ,dat_bis	 
--      ,preisaktiviert_fg
--      ,kjwo_von
--)
--
--SELECT DISTINCT
--mandant_id
--,aktion_id
--,bewart_id
--,aktionsart_id
--,werbe_kat_id
--,dat_von
--,dat_bis
--,preisaktiviert_fg
--,MIN(t.kjwo) OVER (PARTITION BY aktion_id, mandant_id) AS kjwo_von
--FROM
--(
--      SELECT
--            1 AS mandant_id
--            ,aktionsnummer AS aktion_id
--            ,1002 AS bewart_id
--            ,aktionsart AS aktionsart_id 
--            ,dt2.werbe_kat_id_max AS werbe_kat_id
--            ,CAST(gueltig_ab  AS DATE  FORMAT 'DD-MM-YYYY') AS dat_von
--            ,CAST(gueltig_bis AS DATE  FORMAT 'DD-MM-YYYY') AS dat_bis
--            ,CASE WHEN status IS NULL  THEN 0
--                  WHEN status = ''     THEN 0
--                  ELSE 1 END AS preisaktiviert_fg
--      
--      FROM  DBX_LOAD.fww_wme_kopf  dt1
--      
--      LEFT OUTER JOIN
--      
--      (SELECT
--      mandant_id AS mandant_id,
--      MAX(werbe_kat_id) AS werbe_kat_id_max,
--      sap_werbe_kat_id  AS sap_werbe_kat_id
--      FROM
--      DBX_DATA.l_werbekat
--      GROUP BY 1,3
--      ) dt2
--      ON dt1.werbekategorie = dt2.sap_werbe_kat_id
--      WHERE dt2.mandant_id = 1
--)dt
--INNER JOIN DBX_DATA.tag t
--    ON  t.dat BETWEEN  dt.dat_von AND dt.dat_bis
--;
--
--Comment from validation checker
--error line 32 at position 39 unexpected 'FORMAT'.
--            ,CAST(gueltig_ab  AS DATE   ^^^> FORMAT 'DD-MM-YYYY') AS dat_von
--syntax error line 32 at position 46 unexpected ''DD\-MM\-YYYY''.
--            ,CAST(gueltig_ab  AS DATE  FORMAT  ^^^> 'DD-MM-YYYY') AS dat_von
--syntax error line 33 at position 17 unexpected '('.
--            ,CAST ^^^> (gueltig_bis AS DATE  FORMAT 'DD-MM-YYYY') AS dat_bis
--syntax error line 34 at position 23 unexpected 'status'.
--            ,CASE WHEN  ^^^> status IS NULL  THEN 0
--syntax error line 52 at position 0 unexpected ')'.
-- ^^^> )dt
--translated statement
INSERT INTO DBP_DATA.aktion  
(  
       mandant_id  
      ,aktion_id
      ,bewart_id
      ,aktionsart_id
      ,werbe_kat_id
      ,dat_von
      ,dat_bis	 
      ,preisaktiviert_fg
      ,kjwo_von
)

SELECT DISTINCT
mandant_id
,aktion_id
,bewart_id
,aktionsart_id
,werbe_kat_id
,dat_von
,dat_bis
,preisaktiviert_fg
,MIN(t.kjwo) OVER (PARTITION BY aktion_id, mandant_id) AS kjwo_von
FROM
(
      SELECT
            1 AS mandant_id
            ,aktionsnummer AS aktion_id
            ,1002 AS bewart_id
            ,aktionsart AS aktionsart_id 
            ,dt2.werbe_kat_id_max AS werbe_kat_id
            ,CAST(gueltig_ab  AS DATE  FORMAT 'DD-MM-YYYY') AS dat_von
            ,CAST(gueltig_bis AS DATE  FORMAT 'DD-MM-YYYY') AS dat_bis
            ,CASE WHEN status IS NULL  THEN 0
                  WHEN status = ''     THEN 0
                  ELSE 1 END AS preisaktiviert_fg
      
      FROM  DBP_ETL.fww_wme_kopf  dt1
      
      LEFT OUTER JOIN
      
      (SELECT
      mandant_id AS mandant_id,
      MAX(werbe_kat_id) AS werbe_kat_id_max,
      sap_werbe_kat_id  AS sap_werbe_kat_id
      FROM
      DBP_DATA.l_werbekat
      GROUP BY 1,3
      ) dt2
      ON dt1.werbekategorie = dt2.sap_werbe_kat_id
      WHERE dt2.mandant_id = 1
)dt
INNER JOIN DBP_DATA.tag t
    ON  t.dat BETWEEN  dt.dat_von AND dt.dat_bis
;

