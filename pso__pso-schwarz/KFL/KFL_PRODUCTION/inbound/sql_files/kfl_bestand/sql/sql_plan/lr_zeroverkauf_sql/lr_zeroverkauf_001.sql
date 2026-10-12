--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)
CREATE OR REPLACE TRANSIENT TABLE akt_zeitfenster_${TRANSIENT_TABLE_SUFFIX}  (
      mandant_id BYTEINT,
      wup_id INTEGER,
      zeitfenster_id BYTEINT,
      dat DATE,
      wtag_id BYTEINT)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO akt_zeitfenster_${TRANSIENT_TABLE_SUFFIX} (
--    t01.mandant_id
--  , t01.wup_id
--  , zeitfenster_id
--  , dat
--  , wtag_id)
-- 
--SELECT
--   t02.mandant_id
--  , t02.wup_id
--  , CASE
--        /* da seit dem 01.04.2014, Zeitumstellungstag, 'CURRENT_TIME' nicht richtig funktioniert, wurde das alte Statement auskommentiert, der Incident bei TD wurde aufgemacht*/
--        ---WHEN CURRENT_TIME BETWEEN report_zeit_von AND report_zeit_bis --old--
--        WHEN CAST(CURRENT_TIMESTAMP AS TIME) BETWEEN report_zeit_von AND report_zeit_bis --new--
--        THEN zeitfenster_id
--        ELSE NULL END AS zeitfenster_id1
--  , CASE
--        WHEN zeitfenster_id IN (1,2) THEN DATE
--        WHEN zeitfenster_id = 3 THEN DATE - 1
--        ELSE NULL END AS dat
--  , CASE
--        WHEN zeitfenster_id IN (1,2) THEN t03.wtag_id
--        WHEN zeitfenster_id = 3 THEN t03.wtag_id - 1
--        ELSE NULL END AS wtag_id
-- FROM  DBX_DATA.l_zeitfenster  t01
-- CROSS JOIN 
--       DBX_MSI_DATA.l_mk_wup t02
-- INNER JOIN
--       DBX_DATA.tag AS t03 
-- ON DATE =  t03.dat
-- AND zeitfenster_id1 IS NOT NULL;
--
--Comment from validation checker
--error line 31 at position 5
-- AND  ^^^> zeitfenster_id1 IS NOT NULL;
--invalid identifier 'ZEITFENSTER_ID1'
--translated statement
INSERT INTO akt_zeitfenster_${TRANSIENT_TABLE_SUFFIX} (
    mandant_id
  , wup_id
  , zeitfenster_id
  , dat
  , wtag_id)
 SELECT 
        mandant_id,
        wup_id,
        zeitfenster_id1,
        dat,
        wtag_id
FROM (
SELECT
   t02.mandant_id mandant_id
  , t02.wup_id wup_id
  , CASE
        /* da seit dem 01.04.2014, Zeitumstellungstag, 'CURRENT_TIME' nicht richtig funktioniert, wurde das alte Statement auskommentiert, der Incident bei TD wurde aufgemacht*/
        ---WHEN CURRENT_TIME BETWEEN report_zeit_von AND report_zeit_bis --old--
        WHEN CAST(CURRENT_TIMESTAMP AS TIME) BETWEEN report_zeit_von AND report_zeit_bis --new--
        THEN zeitfenster_id
        ELSE NULL END AS zeitfenster_id1
  , CASE
        WHEN zeitfenster_id IN (1,2) THEN CURRENT_DATE
        WHEN zeitfenster_id = 3 THEN CURRENT_DATE - 1
        ELSE NULL END AS dat
  , CASE
        WHEN zeitfenster_id IN (1,2) THEN t03.wtag_id
        WHEN zeitfenster_id = 3 THEN t03.wtag_id - 1
        ELSE NULL END AS wtag_id
 FROM  DBP_DATA.l_zeitfenster  t01
 CROSS JOIN 
       DBP_MSI_DATA.l_mk_wup t02
 INNER JOIN
       DBP_DATA.tag AS t03 
 ON CURRENT_DATE =  t03.dat
 WHERE zeitfenster_id1 IS NOT NULL
) a 

GROUP BY 1,2,3,4,5;

