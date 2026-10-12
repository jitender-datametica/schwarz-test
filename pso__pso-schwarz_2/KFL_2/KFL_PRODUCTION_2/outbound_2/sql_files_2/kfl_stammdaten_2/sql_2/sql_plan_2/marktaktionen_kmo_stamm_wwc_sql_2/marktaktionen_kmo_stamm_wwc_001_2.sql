--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE SET TEMPORARY TABLE #tage AS (
--SELECT dat
--FROM DBX_DATA.tag_2
--WHERE dat BETWEEN DATE-45 AND DATE
--GROUP BY 1
--) WITH DATA
--  ON COMMIT PRESERVE ROWS
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


CREATE OR REPLACE TEMPORARY TABLE _tage AS
SELECT dat
FROM dbp_data.tag_2
WHERE dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 45 DAY) AND (CURRENT_DATE("Europe/Berlin"))
GROUP BY dat;


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE MULTISET TEMPORARY TABLE #x1 AS (
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
--      FROM DBX_DATA.aktion_2 a
--      JOIN DBX_DATA.aktion_art_wup_zu_2 b
--        ON a.mandant_id = b.mandant_id AND
--           a.aktion_id = b.aktion_id
--      WHERE (UPPER(b.grund_sperrung) <> 'X' OR 
--             b.grund_sperrung IS NULL) AND
--             a.mandant_id > 1
--      GROUP BY 1,2,3,4,5,6,7,8,9,10) b
--  ON a.dat BETWEEN b.dat_von AND b.dat_bis
--JOIN DBX_DATA.art_2 c
--  ON b.mandant_id = c.mandant_id AND
--     b.art_id = c.art_id
--JOIN DBX_DATA.mandant_2 d
--  ON b.mandant_id = d.mandant_id
--GROUP BY 1,2,3,4,5,6,7,8,9,10,11
--) WITH DATA
--PRIMARY INDEX (art_id,wup_id)
--ON COMMIT PRESERVE ROWS
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


CREATE TEMPORARY TABLE IF NOT EXISTS _x1 AS
SELECT
    b.wup_id,
    b.nb_id,
    b.aktion_id,
    b.mandant_id,
    A.dat,
    b.art_id,
    b.vk_aktion_brutto,
    b.vk_vor_aktion_brutto,
    C.mwst_id,
    D.default_wrg AS wrg_id,
    b.dat_preisaktiviert
FROM dbp_data.`_tage` AS A
INNER JOIN (
    SELECT
        A0.mandant_id,
        A0.aktion_id,
        A0.dat_von,
        A0.dat_bis,
        B.wup_id,
        B.nb_id,
        B.art_id,
        B.vk_aktion_brutto,
        B.vk_vor_aktion_brutto,
        B.dat_preisaktiviert
    FROM dbp_data.aktion_2 AS A0
    INNER JOIN dbp_data.aktion_art_wup_zu_2 AS B ON A0.mandant_id = B.mandant_id AND A0.aktion_id = B.aktion_id

    WHERE
        (UPPER(B.grund_sperrung) <> 'X' OR B.grund_sperrung IS NULL)
        AND A0.mandant_id > 1
    GROUP BY
        A0.mandant_id,
        A0.aktion_id,
        A0.dat_von,
        A0.dat_bis,
        B.wup_id,
        B.nb_id,
        B.art_id,
        B.vk_aktion_brutto,
        B.vk_vor_aktion_brutto,
        B.dat_preisaktiviert
) AS b ON A.dat BETWEEN b.dat_von AND b.dat_bis
INNER JOIN dbp_data.art_2 AS C ON b.mandant_id = C.mandant_id AND b.art_id = C.art_id
INNER JOIN dbp_data.mandant_2 AS D ON b.mandant_id = D.mandant_id
GROUP BY
    b.wup_id,
    b.nb_id,
    b.aktion_id,
    b.mandant_id,
    A.dat,
    b.art_id,
    b.vk_aktion_brutto,
    b.vk_vor_aktion_brutto,
    C.mwst_id,
    wrg_id,
    b.dat_preisaktiviert;


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM #x1
--WHERE mandant_id IN (7) AND
--     (mandant_id,aktion_id) IN (SELECT mandant_id,aktion_id FROM DBX_DATA.l_bonuskauf_2)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


DELETE FROM `_x1`
WHERE mandant_id IN (
    7) AND (mandant_id, aktion_id) IN (
    SELECT (mandant_id, aktion_id)
    FROM dbp_data.l_bonuskauf_2
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM #x1
--WHERE mandant_id IN (2) AND
--      dat >= 1200120 AND
--     (mandant_id,aktion_id) IN (SELECT mandant_id,aktion_id FROM DBX_DATA.l_bonuskauf_2)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


DELETE FROM `_x1`
WHERE mandant_id IN (
    2) AND dat >= DATE '2020-01-20' AND (mandant_id, aktion_id) IN (
    SELECT (mandant_id, aktion_id)
    FROM dbp_data.l_bonuskauf_2
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM #x1
--WHERE mandant_id IN (4) AND
--      dat >= 1200120 AND
--     (mandant_id,aktion_id) IN (SELECT mandant_id,aktion_id FROM DBX_DATA.l_bonuskauf_2)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


DELETE FROM `_x1`
WHERE mandant_id IN (
    4) AND dat >= DATE '2020-01-20' AND (mandant_id, aktion_id) IN (
    SELECT (mandant_id, aktion_id)
    FROM dbp_data.l_bonuskauf_2
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM #x1
--WHERE mandant_id IN (3) AND
--      dat >= 1200401 AND
--     (mandant_id,aktion_id) IN (SELECT mandant_id,aktion_id FROM DBX_DATA.l_bonuskauf_2)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


DELETE FROM `_x1`
WHERE mandant_id IN (3) AND dat >= PARSE_DATE('%F', '2020-04-01') AND (mandant_id, aktion_id) IN (SELECT (
    mandant_id,
    aktion_id
)
FROM dbp_data.l_bonuskauf_2);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE TEMPORARY TABLE #x2 AS #x1 
--WITH NO DATA AND STATS ON COMMIT PRESERVE ROWS;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


CREATE TEMPORARY TABLE IF NOT EXISTS _x2 (
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    aktion_id STRING(10) NOT NULL,
    mandant_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    art_id INTEGER NOT NULL,
    vk_aktion_brutto NUMERIC(29, 2) NOT NULL,
    vk_vor_aktion_brutto NUMERIC(29, 2) NOT NULL,
    mwst_id INTEGER NOT NULL,
    wrg_id STRING(12) NOT NULL,
    dat_preisaktiviert DATE NOT NULL
);


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
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


INSERT INTO `_x2`
(
    SELECT
        A.wup_id,
        A.nb_id,
        A.aktion_id,
        A.mandant_id,
        A.dat,
        A.art_id,
        A.vk_aktion_brutto,
        A.vk_vor_aktion_brutto,
        A.mwst_id,
        A.wrg_id,
        A.dat_preisaktiviert
    FROM `_x1` AS A
    INNER JOIN (SELECT
        wup_id,
        nb_id,
        mandant_id,
        dat,
        art_id
    FROM `_x1`
    GROUP BY
        wup_id,
        nb_id,
        mandant_id,
        dat,
        art_id
    HAVING COUNT(*) = 1) AS b
        ON
            A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.nb_id = b.nb_id AND A.dat = b.dat AND A.art_id = b.art_id
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM #x1
--WHERE (mandant_id,wup_id,nb_id,dat,art_id) IN (SELECT mandant_id,wup_id,nb_id,dat,art_id
--                                               FROM #x2)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


DELETE FROM `_x1`
WHERE (
    mandant_id, wup_id, nb_id, dat, art_id) IN (
    SELECT (mandant_id, wup_id, nb_id, dat, art_id)
    FROM `_x2`
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : Literal 101 might mean_2 date. Manual check is required.
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
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


INSERT INTO `_x2`
(
    SELECT
        A.wup_id,
        A.nb_id,
        A.aktion_id,
        A.mandant_id,
        A.dat,
        A.art_id,
        A.vk_aktion_brutto,
        A.vk_vor_aktion_brutto,
        A.mwst_id,
        A.wrg_id,
        A.dat_preisaktiviert
    FROM `_x1` AS A
    INNER JOIN (
        SELECT
            x.wup_id,
            x.nb_id,
            x.mandant_id,
            x.dat,
            x.art_id,
            y.aktion_id
        FROM (
            SELECT
                wup_id,
                nb_id,
                mandant_id,
                dat,
                art_id
            FROM `_x1`
            WHERE dat_preisaktiviert <> DATE '1900-01-01'
            GROUP BY
                wup_id,
                nb_id,
                mandant_id,
                dat,
                art_id
        ) AS x
        INNER JOIN (SELECT
            wup_id,
            nb_id,
            mandant_id,
            dat,
            art_id,
            aktion_id
        FROM (SELECT
            wup_id,
            nb_id,
            mandant_id,
            dat,
            art_id,
            MAX(aktion_id) AS aktion_id,
            COUNT(*) AS a0
        FROM `_x1`
        WHERE dat_preisaktiviert <> DATE '1900-01-01'
        GROUP BY
            wup_id,
            nb_id,
            mandant_id,
            dat,
            art_id
        HAVING a0 = 1) AS t3) AS y
            ON
                x.mandant_id = y.mandant_id AND x.wup_id = y.wup_id AND x.nb_id = y.nb_id AND x.art_id
                = y.art_id AND x.dat = y.dat
    ) AS b
        ON
            A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.nb_id = b.nb_id
            AND A.dat = b.dat AND A.art_id = b.art_id AND A.aktion_id = b.aktion_id
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM #x1
--WHERE (mandant_id,wup_id,nb_id,dat,art_id) IN (SELECT mandant_id,wup_id,nb_id,dat,art_id
--                                               FROM #x2)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


DELETE FROM `_x1`
WHERE (
    mandant_id, wup_id, nb_id, dat, art_id) IN (
    SELECT (mandant_id, wup_id, nb_id, dat, art_id)
    FROM `_x2`
);


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
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


INSERT INTO `_x2`
(
    SELECT
        A.wup_id,
        A.nb_id,
        A.aktion_id,
        A.mandant_id,
        A.dat,
        A.art_id,
        A.vk_aktion_brutto,
        A.vk_vor_aktion_brutto,
        A.mwst_id,
        A.wrg_id,
        A.dat_preisaktiviert
    FROM `_x1` AS A
    INNER JOIN (
        SELECT
            x.wup_id,
            x.nb_id,
            x.mandant_id,
            x.dat,
            x.art_id,
            y.aktion_id
        FROM (
            SELECT
                wup_id,
                nb_id,
                mandant_id,
                dat,
                art_id
            FROM `_x1`
            WHERE LENGTH(TRIM(aktion_id)) = 8
            GROUP BY
                wup_id,
                nb_id,
                mandant_id,
                dat,
                art_id
        ) AS x
        INNER JOIN (SELECT
            wup_id,
            nb_id,
            mandant_id,
            dat,
            art_id,
            aktion_id
        FROM (SELECT
            wup_id,
            nb_id,
            mandant_id,
            dat,
            art_id,
            MAX(aktion_id) AS aktion_id,
            COUNT(*) AS a0
        FROM `_x1`
        WHERE LENGTH(TRIM(aktion_id)) = 8
        GROUP BY
            wup_id,
            nb_id,
            mandant_id,
            dat,
            art_id
        HAVING a0 = 1) AS t3) AS y
            ON
                x.mandant_id = y.mandant_id AND x.wup_id = y.wup_id AND x.nb_id = y.nb_id AND x.art_id
                = y.art_id AND x.dat = y.dat
    ) AS b
        ON
            A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.nb_id = b.nb_id
            AND A.dat = b.dat AND A.art_id = b.art_id AND A.aktion_id = b.aktion_id
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM #x1
--WHERE (mandant_id,wup_id,nb_id,dat,art_id) IN (SELECT mandant_id,wup_id,nb_id,dat,art_id
--                                               FROM #x2)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


DELETE FROM `_x1`
WHERE (
    mandant_id, wup_id, nb_id, dat, art_id) IN (
    SELECT (mandant_id, wup_id, nb_id, dat, art_id)
    FROM `_x2`
);


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
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


INSERT INTO `_x2`
(
    SELECT
        A.wup_id,
        A.nb_id,
        A.aktion_id,
        A.mandant_id,
        A.dat,
        A.art_id,
        A.vk_aktion_brutto,
        A.vk_vor_aktion_brutto,
        A.mwst_id,
        A.wrg_id,
        A.dat_preisaktiviert
    FROM `_x1` AS A
    INNER JOIN (
        SELECT
            x.wup_id,
            x.nb_id,
            x.mandant_id,
            x.dat,
            x.art_id,
            x.dat_preisaktiviert,
            y.aktion_id
        FROM (
            SELECT
                wup_id,
                nb_id,
                mandant_id,
                dat,
                art_id,
                MAX(dat_preisaktiviert) AS dat_preisaktiviert
            FROM `_x1`
            GROUP BY
                wup_id,
                nb_id,
                mandant_id,
                dat,
                art_id
        ) AS x
        INNER JOIN (SELECT
            wup_id,
            nb_id,
            mandant_id,
            dat,
            art_id,
            dat_preisaktiviert,
            aktion_id
        FROM (SELECT
            wup_id,
            nb_id,
            mandant_id,
            dat,
            art_id,
            dat_preisaktiviert,
            MAX(aktion_id) AS aktion_id,
            COUNT(*) AS a0
        FROM `_x1`
        GROUP BY
            wup_id,
            nb_id,
            mandant_id,
            dat,
            art_id,
            dat_preisaktiviert
        HAVING a0 = 1) AS t1_2) AS y
            ON
                x.mandant_id = y.mandant_id AND x.wup_id = y.wup_id AND x.nb_id = y.nb_id AND x.dat
                = y.dat AND x.art_id = y.art_id AND x.dat_preisaktiviert = y.dat_preisaktiviert
        GROUP BY
            x.wup_id,
            x.nb_id,
            x.mandant_id,
            x.dat,
            x.art_id,
            x.dat_preisaktiviert,
            y.aktion_id
    ) AS b
        ON
            A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.nb_id = b.nb_id AND A.dat = b.dat AND
            A.art_id = b.art_id AND A.aktion_id = b.aktion_id AND A.dat_preisaktiviert = b.dat_preisaktiviert
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM #x1
--WHERE (mandant_id,wup_id,nb_id,dat,art_id) IN (SELECT mandant_id,wup_id,nb_id,dat,art_id
--                                               FROM #x2)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


DELETE FROM `_x1`
WHERE (
    mandant_id, wup_id, nb_id, dat, art_id) IN (
    SELECT (mandant_id, wup_id, nb_id, dat, art_id)
    FROM `_x2`
);


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
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


INSERT INTO `_x2`
(
    SELECT
        A.wup_id,
        A.nb_id,
        A.aktion_id,
        A.mandant_id,
        A.dat,
        A.art_id,
        A.vk_aktion_brutto,
        A.vk_vor_aktion_brutto,
        A.mwst_id,
        A.wrg_id,
        A.dat_preisaktiviert
    FROM `_x1` AS A
    INNER JOIN (
        SELECT
            X.wup_id,
            X.nb_id,
            X.mandant_id,
            X.dat,
            X.art_id,
            X.aktion_id
        FROM `_x1` AS X
        INNER JOIN (
            SELECT
                wup_id,
                nb_id,
                mandant_id,
                dat,
                art_id,
                MAX(aktion_id) AS aktion_id
            FROM `_x1`
            GROUP BY
                wup_id,
                nb_id,
                mandant_id,
                dat,
                art_id
        ) AS y
            ON
                X.mandant_id = y.mandant_id AND X.wup_id = y.wup_id AND X.nb_id = y.nb_id AND X.dat = y.dat AND X.art_id = y.art_id AND X.aktion_id = y.aktion_id
        GROUP BY
            X.wup_id,
            X.nb_id,
            X.aktion_id,
            X.mandant_id,
            X.dat,
            X.art_id
    ) AS t1_2
        ON
            A.mandant_id = t1.mandant_id AND A.wup_id = t1.wup_id AND A.nb_id = t1.nb_id AND A.dat = t1.dat
            AND A.art_id = t1.art_id AND A.aktion_id = t1.aktion_id
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM #x1
--WHERE (mandant_id,wup_id,nb_id,dat,art_id) IN (SELECT mandant_id,wup_id,nb_id,dat,art_id
--                                               FROM #x2)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


DELETE FROM `_x1`
WHERE (
    mandant_id, wup_id, nb_id, dat, art_id) IN (
    SELECT (mandant_id, wup_id, nb_id, dat, art_id)
    FROM `_x2`
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBX_PROCESS.marktabschriften_stamm_wwc_2
--WHERE dat IN (SELECT dat FROM #tage)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


DELETE FROM dbp_etl_process.marktabschriften_stamm_wwc_2
WHERE dat IN (
    SELECT dat
    FROM dbp_data.`_tage`
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_PROCESS.marktabschriften_stamm_wwc_2 (wup_id
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
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement


INSERT INTO dbp_etl_process.marktabschriften_stamm_wwc_2 (
    wup_id, nb_id, aktion_id, mandant_id, bewart_id,
    dat, art_id, vk_aktion_brutto, vk_vor_aktion_brutto, mwst_id, wrg_id, dat_preisaktiviert, aktion_relevant_fg
)
(SELECT
    wup_id,
    nb_id,
    aktion_id,
    mandant_id,
    1002 AS bewart_id,
    dat,
    art_id,
    vk_aktion_brutto,
    vk_vor_aktion_brutto,
    mwst_id,
    wrg_id,
    dat_preisaktiviert,
    1 AS aktion_relevant_fg
FROM `_x2`);
