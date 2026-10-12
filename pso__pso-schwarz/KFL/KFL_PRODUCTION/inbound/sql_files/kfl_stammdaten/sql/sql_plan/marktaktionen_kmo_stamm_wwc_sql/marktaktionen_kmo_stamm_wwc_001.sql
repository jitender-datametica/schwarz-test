--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE SET VOLATILE TABLE #tage AS (
--SELECT dat
--FROM DBX_DATA.tag
--WHERE dat BETWEEN DATE-45 AND DATE
--GROUP BY 1
--) WITH DATA
--  ON COMMIT PRESERVE ROWS
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
CREATE or replace VOLATILE TABLE _tage AS (
SELECT dat
FROM DBP_DATA.tag
WHERE dat BETWEEN CURRENT_DATE-45 AND CURRENT_DATE
GROUP BY 1
);

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE MULTISET VOLATILE TABLE #x1 AS (
--SELECT  b.wup_id,
--        b.nb_id,
--        b.aktion_id,
--        b.mandant_id,
--        a.dat,
--        b.art_id,
--        b.vk_aktion_brutto,
--        b.vk_vor_aktion_brutto,
--        c.mwst_id,
--        d.default_wrg AS wrg_id,
--        b.dat_preisaktiviert
--FROM #tage a
--JOIN (SELECT a.mandant_id,
--             a.aktion_id,
--             a.dat_von,
--             a.dat_bis,
--             b.wup_id,
--             b.nb_id,
--             b.art_id,
--             b.vk_aktion_brutto,
--             b.vk_vor_aktion_brutto,
--             b.dat_preisaktiviert
--      FROM DBX_DATA.aktion a
--      JOIN DBX_DATA.aktion_art_wup_zu b
--        ON a.mandant_id = b.mandant_id AND
--           a.aktion_id = b.aktion_id
--      WHERE (UPPER(b.grund_sperrung) <> 'X' OR 
--             b.grund_sperrung IS NULL) AND
--             a.mandant_id > 1
--      GROUP BY 1,2,3,4,5,6,7,8,9,10) b
--  ON a.dat BETWEEN b.dat_von AND b.dat_bis
--JOIN DBX_DATA.art c
--  ON b.mandant_id = c.mandant_id AND
--     b.art_id = c.art_id
--JOIN DBX_DATA.mandant d
--  ON b.mandant_id = d.mandant_id
--GROUP BY 1,2,3,4,5,6,7,8,9,10,11
--) WITH DATA
--PRIMARY INDEX (art_id,wup_id)
--ON COMMIT PRESERVE ROWS
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
CREATE  VOLATILE TABLE _x1 AS (
SELECT  b.wup_id,
        b.nb_id,
        b.aktion_id,
        b.mandant_id,
        a.dat,
        b.art_id,
        b.vk_aktion_brutto,
        b.vk_vor_aktion_brutto,
        c.mwst_id,
        d.default_wrg AS wrg_id,
        b.dat_preisaktiviert
FROM _tage a
JOIN (SELECT a.mandant_id,
             a.aktion_id,
             a.dat_von,
             a.dat_bis,
             b.wup_id,
             b.nb_id,
             b.art_id,
             b.vk_aktion_brutto,
             b.vk_vor_aktion_brutto,
             b.dat_preisaktiviert
      FROM DBP_DATA.aktion a
      JOIN DBP_DATA.aktion_art_wup_zu b
        ON a.mandant_id = b.mandant_id AND
           a.aktion_id = b.aktion_id
      WHERE (UPPER(b.grund_sperrung) <> 'X' OR 
             b.grund_sperrung IS NULL) AND
             a.mandant_id > 1
      GROUP BY 1,2,3,4,5,6,7,8,9,10) b
  ON a.dat BETWEEN b.dat_von AND b.dat_bis
JOIN DBP_DATA.art c
  ON b.mandant_id = c.mandant_id AND
     b.art_id = c.art_id
JOIN DBP_DATA.mandant d
  ON b.mandant_id = d.mandant_id
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
);

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM #x1
--WHERE mandant_id IN (7) AND
--     (mandant_id,aktion_id) IN (SELECT mandant_id,aktion_id FROM DBX_DATA.l_bonuskauf)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
DELETE FROM _x1
WHERE mandant_id IN (7) AND
     (mandant_id,aktion_id) IN (SELECT mandant_id,aktion_id FROM DBP_DATA.l_bonuskauf)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM #x1
--WHERE mandant_id IN (2) AND
--      dat >= 1200120 AND
--     (mandant_id,aktion_id) IN (SELECT mandant_id,aktion_id FROM DBX_DATA.l_bonuskauf)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
DELETE FROM _x1
WHERE mandant_id IN (2) AND
      dat >= '2020-01-20' AND
     (mandant_id,aktion_id) IN (SELECT mandant_id,aktion_id FROM DBP_DATA.l_bonuskauf)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM #x1
--WHERE mandant_id IN (4) AND
--      dat >= 1200120 AND
--     (mandant_id,aktion_id) IN (SELECT mandant_id,aktion_id FROM DBX_DATA.l_bonuskauf)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
DELETE FROM _x1
WHERE mandant_id IN (4) AND
      dat >= '2020-01-20' AND
     (mandant_id,aktion_id) IN (SELECT mandant_id,aktion_id FROM DBP_DATA.l_bonuskauf)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM #x1
--WHERE mandant_id IN (3) AND
--      dat >= 1200401 AND
--     (mandant_id,aktion_id) IN (SELECT mandant_id,aktion_id FROM DBX_DATA.l_bonuskauf)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
DELETE FROM _x1
WHERE mandant_id IN (3) AND
      dat >= to_date('2020-04-01','YYYY-MM-DD') AND
     (mandant_id,aktion_id) IN (SELECT mandant_id,aktion_id FROM DBP_DATA.l_bonuskauf)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE VOLATILE TABLE #x2 AS #x1 
--WITH NO DATA AND STATS ON COMMIT PRESERVE ROWS;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
CREATE VOLATILE TABLE _x2 LIKE _x1;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO #x2
--SELECT a.*
--FROM #x1 a
--JOIN (SELECT wup_id,
--             nb_id,
--             mandant_id,
--             dat,
--             art_id
--      FROM #x1
--      GROUP BY 1,2,3,4,5
--      HAVING COUNT(*) = 1) b
--ON a.mandant_id = b.mandant_id AND
--    a.wup_id = b.wup_id AND
--    a.nb_id = b.nb_id AND
--    a.dat = b.dat AND
--    a.art_id = b.art_id
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
INSERT INTO _x2
SELECT a.*
FROM _x1 a
JOIN (SELECT wup_id,
             nb_id,
             mandant_id,
             dat,
             art_id
      FROM _x1
      GROUP BY 1,2,3,4,5
      HAVING COUNT(*) = 1) b
ON a.mandant_id = b.mandant_id AND
    a.wup_id = b.wup_id AND
    a.nb_id = b.nb_id AND
    a.dat = b.dat AND
    a.art_id = b.art_id
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM #x1
--WHERE (mandant_id,wup_id,nb_id,dat,art_id) IN (SELECT mandant_id,wup_id,nb_id,dat,art_id
--                                               FROM #x2)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
DELETE FROM _x1
WHERE (mandant_id,wup_id,nb_id,dat,art_id) IN (SELECT mandant_id,wup_id,nb_id,dat,art_id
                                               FROM _x2)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : Literal 101 might mean date. Manual check is required.
--original statement
--INSERT INTO #x2
--SELECT a.*
--FROM #x1 a
--JOIN (SELECT x.wup_id,
--             x.nb_id,
--             x.mandant_id,
--             x.dat,
--             x.art_id,
--             y.aktion_id
--      FROM (SELECT wup_id,
--                   nb_id,
--                   mandant_id,
--                   dat,
--                   art_id
--            FROM #x1
--            WHERE dat_preisaktiviert <> 101
--            GROUP BY 1,2,3,4,5) x
--      JOIN (SELECT wup_id,
--                   nb_id,
--                   mandant_id,
--                   dat,
--                   art_id,
--                   MAX(aktion_id) AS aktion_id
--            FROM #x1
--            WHERE dat_preisaktiviert <> 101
--            GROUP BY 1,2,3,4,5
--            HAVING COUNT(*) = 1) y
--        ON x.mandant_id = y.mandant_id AND
--           x.wup_id = y.wup_id AND
--           x.nb_id = y.nb_id AND
--           x.art_id = y.art_id AND
--           x.dat = y.dat) b
--  ON a.mandant_id = b.mandant_id AND
--     a.wup_id = b.wup_id AND
--     a.nb_id = b.nb_id AND
--     a.dat = b.dat AND
--     a.art_id = b.art_id AND
--     a.aktion_id = b.aktion_id
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
INSERT INTO _x2
SELECT a.*
FROM _x1 a
JOIN (SELECT x.wup_id,
             x.nb_id,
             x.mandant_id,
             x.dat,
             x.art_id,
             y.aktion_id
      FROM (SELECT wup_id,
                   nb_id,
                   mandant_id,
                   dat,
                   art_id
            FROM _x1
            WHERE dat_preisaktiviert <> '1900-01-01'
            GROUP BY 1,2,3,4,5) x
      JOIN (SELECT wup_id,
                   nb_id,
                   mandant_id,
                   dat,
                   art_id,
                   MAX(aktion_id) AS aktion_id
            FROM _x1
            WHERE dat_preisaktiviert <> '1900-01-01'
            GROUP BY 1,2,3,4,5
            HAVING COUNT(*) = 1) y
        ON x.mandant_id = y.mandant_id AND
           x.wup_id = y.wup_id AND
           x.nb_id = y.nb_id AND
           x.art_id = y.art_id AND
           x.dat = y.dat) b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.nb_id = b.nb_id AND
     a.dat = b.dat AND
     a.art_id = b.art_id AND
     a.aktion_id = b.aktion_id
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM #x1
--WHERE (mandant_id,wup_id,nb_id,dat,art_id) IN (SELECT mandant_id,wup_id,nb_id,dat,art_id
--                                               FROM #x2)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
DELETE FROM _x1
WHERE (mandant_id,wup_id,nb_id,dat,art_id) IN (SELECT mandant_id,wup_id,nb_id,dat,art_id
                                               FROM _x2)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO #x2
--SELECT a.*
--FROM #x1 a
--JOIN (SELECT x.wup_id,
--             x.nb_id,
--             x.mandant_id,
--             x.dat,
--             x.art_id,
--             y.aktion_id
--      FROM (SELECT wup_id,
--                   nb_id,
--                   mandant_id,
--                   dat,
--                   art_id
--            FROM #x1
--            WHERE LEN(TRIM(aktion_id)) = 8
--            GROUP BY 1,2,3,4,5) x
--      JOIN (SELECT wup_id,
--                   nb_id,
--                   mandant_id,
--                   dat,
--                   art_id,
--                   MAX(aktion_id) AS aktion_id
--            FROM #x1
--            WHERE LEN(TRIM(aktion_id)) = 8
--            GROUP BY 1,2,3,4,5
--            HAVING COUNT(*) = 1) y
--        ON x.mandant_id = y.mandant_id AND
--           x.wup_id = y.wup_id AND
--           x.nb_id = y.nb_id AND
--           x.art_id = y.art_id AND
--           x.dat = y.dat) b
--  ON a.mandant_id = b.mandant_id AND
--     a.wup_id = b.wup_id AND
--     a.nb_id = b.nb_id AND
--     a.dat = b.dat AND
--     a.art_id = b.art_id AND
--     a.aktion_id = b.aktion_id
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
INSERT INTO _x2
SELECT a.*
FROM _x1 a
JOIN (SELECT x.wup_id,
             x.nb_id,
             x.mandant_id,
             x.dat,
             x.art_id,
             y.aktion_id
      FROM (SELECT wup_id,
                   nb_id,
                   mandant_id,
                   dat,
                   art_id
            FROM _x1
            WHERE LEN(TRIM(aktion_id)) = 8
            GROUP BY 1,2,3,4,5) x
      JOIN (SELECT wup_id,
                   nb_id,
                   mandant_id,
                   dat,
                   art_id,
                   MAX(aktion_id) AS aktion_id
            FROM _x1
            WHERE LEN(TRIM(aktion_id)) = 8
            GROUP BY 1,2,3,4,5
            HAVING COUNT(*) = 1) y
        ON x.mandant_id = y.mandant_id AND
           x.wup_id = y.wup_id AND
           x.nb_id = y.nb_id AND
           x.art_id = y.art_id AND
           x.dat = y.dat) b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.nb_id = b.nb_id AND
     a.dat = b.dat AND
     a.art_id = b.art_id AND
     a.aktion_id = b.aktion_id
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM #x1
--WHERE (mandant_id,wup_id,nb_id,dat,art_id) IN (SELECT mandant_id,wup_id,nb_id,dat,art_id
--                                               FROM #x2)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
DELETE FROM _x1
WHERE (mandant_id,wup_id,nb_id,dat,art_id) IN (SELECT mandant_id,wup_id,nb_id,dat,art_id
                                               FROM _x2)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO #x2
--SELECT a.*
--FROM #x1 a
--JOIN (SELECT x.wup_id,
--             x.nb_id,
--             x.mandant_id,
--             x.dat,
--             x.art_id,
--             x.dat_preisaktiviert,
--             y.aktion_id
--      FROM (SELECT wup_id,
--                   nb_id,
--                   mandant_id,
--                   dat,
--                   art_id,
--                   MAX(dat_preisaktiviert) AS dat_preisaktiviert
--                   FROM #x1
--            GROUP BY 1,2,3,4,5) x
--      JOIN (SELECT wup_id,
--                   nb_id,
--                   mandant_id,
--                   dat,
--                   art_id,
--                   dat_preisaktiviert,
--                   MAX(aktion_id) AS aktion_id
--            FROM #x1
--            GROUP BY 1,2,3,4,5,6
--            HAVING COUNT(*) = 1) y
--        ON x.mandant_id = y.mandant_id AND
--           x.wup_id = y.wup_id AND
--           x.nb_id = y.nb_id AND
--           x.dat = y.dat AND
--           x.art_id = y.art_id AND
--           x.dat_preisaktiviert = y.dat_preisaktiviert
--      GROUP BY 1,2,3,4,5,6,7) b
--ON a.mandant_id = b.mandant_id AND
--   a.wup_id = b.wup_id AND
--   a.nb_id = b.nb_id AND
--   a.dat = b.dat AND
--   a.art_id = b.art_id AND
--   a.aktion_id = b.aktion_id AND
--   a.dat_preisaktiviert = b.dat_preisaktiviert
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
INSERT INTO _x2
SELECT a.*
FROM _x1 a
JOIN (SELECT x.wup_id,
             x.nb_id,
             x.mandant_id,
             x.dat,
             x.art_id,
             x.dat_preisaktiviert,
             y.aktion_id
      FROM (SELECT wup_id,
                   nb_id,
                   mandant_id,
                   dat,
                   art_id,
                   MAX(dat_preisaktiviert) AS dat_preisaktiviert
                   FROM _x1
            GROUP BY 1,2,3,4,5) x
      JOIN (SELECT wup_id,
                   nb_id,
                   mandant_id,
                   dat,
                   art_id,
                   dat_preisaktiviert,
                   MAX(aktion_id) AS aktion_id
            FROM _x1
            GROUP BY 1,2,3,4,5,6
            HAVING COUNT(*) = 1) y
        ON x.mandant_id = y.mandant_id AND
           x.wup_id = y.wup_id AND
           x.nb_id = y.nb_id AND
           x.dat = y.dat AND
           x.art_id = y.art_id AND
           x.dat_preisaktiviert = y.dat_preisaktiviert
      GROUP BY 1,2,3,4,5,6,7) b
ON a.mandant_id = b.mandant_id AND
   a.wup_id = b.wup_id AND
   a.nb_id = b.nb_id AND
   a.dat = b.dat AND
   a.art_id = b.art_id AND
   a.aktion_id = b.aktion_id AND
   a.dat_preisaktiviert = b.dat_preisaktiviert
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM #x1
--WHERE (mandant_id,wup_id,nb_id,dat,art_id) IN (SELECT mandant_id,wup_id,nb_id,dat,art_id
--                                               FROM #x2)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
DELETE FROM _x1
WHERE (mandant_id,wup_id,nb_id,dat,art_id) IN (SELECT mandant_id,wup_id,nb_id,dat,art_id
                                               FROM _x2)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO #x2
--SELECT a.*
--FROM #x1 a
--JOIN (SELECT x.wup_id,
--             x.nb_id,
--             x.mandant_id,
--             x.dat,
--             x.art_id,
--             x.aktion_id
--      FROM #x1 x
--      JOIN (SELECT wup_id,
--                   nb_id,
--                   mandant_id,
--                   dat,
--                   art_id,
--                   MAX(aktion_id) AS aktion_id
--            FROM #x1
--            GROUP BY 1,2,3,4,5) y
--        ON x.mandant_id = y.mandant_id AND
--           x.wup_id = y.wup_id AND
--           x.nb_id = y.nb_id AND
--           x.dat = y.dat AND
--           x.art_id = y.art_id AND
--           x.aktion_id = y.aktion_id
--      GROUP BY 1,2,3,4,5,6) b
--  ON a.mandant_id = b.mandant_id AND
--     a.wup_id = b.wup_id AND
--     a.nb_id = b.nb_id AND
--     a.dat = b.dat AND
--     a.art_id = b.art_id AND
--     a.aktion_id = b.aktion_id
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
INSERT INTO _x2
SELECT a.*
FROM _x1 a
JOIN (SELECT x.wup_id,
             x.nb_id,
             x.mandant_id,
             x.dat,
             x.art_id,
             x.aktion_id
      FROM _x1 x
      JOIN (SELECT wup_id,
                   nb_id,
                   mandant_id,
                   dat,
                   art_id,
                   MAX(aktion_id) AS aktion_id
            FROM _x1
            GROUP BY 1,2,3,4,5) y
        ON x.mandant_id = y.mandant_id AND
           x.wup_id = y.wup_id AND
           x.nb_id = y.nb_id AND
           x.dat = y.dat AND
           x.art_id = y.art_id AND
           x.aktion_id = y.aktion_id
      GROUP BY 1,2,3,4,5,6) b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.nb_id = b.nb_id AND
     a.dat = b.dat AND
     a.art_id = b.art_id AND
     a.aktion_id = b.aktion_id
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM #x1
--WHERE (mandant_id,wup_id,nb_id,dat,art_id) IN (SELECT mandant_id,wup_id,nb_id,dat,art_id
--                                               FROM #x2)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
DELETE FROM _x1
WHERE (mandant_id,wup_id,nb_id,dat,art_id) IN (SELECT mandant_id,wup_id,nb_id,dat,art_id
                                               FROM _x2)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBX_PROCESS.marktabschriften_stamm_wwc
--WHERE dat IN (SELECT dat FROM #tage)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
DELETE FROM DBP_ETL_PROCESS.marktabschriften_stamm_wwc
WHERE dat IN 
(SELECT dat FROM _tage)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_PROCESS.marktabschriften_stamm_wwc (wup_id
--                                                                 ,nb_id
--                                                                 ,aktion_id
--                                                                 ,mandant_id
--                                                                 ,bewart_id
--                                                                 ,dat
--                                                                 ,art_id
--                                                                 ,vk_aktion_brutto
--                                                                 ,vk_vor_aktion_brutto
--                                                                 ,mwst_id
--                                                                 ,wrg_id
--                                                                 ,dat_preisaktiviert
--                                                                 ,aktion_relevant_fg)
--SELECT wup_id
--      ,nb_id
--      ,aktion_id
--      ,mandant_id
--      ,1002 AS bewart_id
--      ,dat
--      ,art_id
--      ,vk_aktion_brutto
--      ,vk_vor_aktion_brutto
--      ,mwst_id
--      ,wrg_id
--      ,dat_preisaktiviert
--      ,1 AS aktion_relevant_fg
--FROM #x2
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
INSERT INTO DBP_ETL_PROCESS.marktabschriften_stamm_wwc (wup_id
                                                                 ,nb_id
                                                                 ,aktion_id
                                                                 ,mandant_id
                                                                 ,bewart_id
                                                                 ,dat
                                                                 ,art_id
                                                                 ,vk_aktion_brutto
                                                                 ,vk_vor_aktion_brutto
                                                                 ,mwst_id
                                                                 ,wrg_id
                                                                 ,dat_preisaktiviert
                                                                 ,aktion_relevant_fg)
SELECT wup_id
      ,nb_id
      ,aktion_id
      ,mandant_id
      ,1002 AS bewart_id
      ,dat
      ,art_id
      ,vk_aktion_brutto
      ,vk_vor_aktion_brutto
      ,mwst_id
      ,wrg_id
      ,dat_preisaktiviert
      ,1 AS aktion_relevant_fg
FROM _x2
;

