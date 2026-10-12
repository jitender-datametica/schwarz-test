--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE DBX_LOAD.sternchen_logik_tmp_1;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
DROP TABLE IF EXISTS DBP_ETL.sternchen_logik_tmp_1;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
--original statement
--CREATE SET TABLE DBX_LOAD.sternchen_logik_tmp_1,
--NO FALLBACK,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL,
--CHECKSUM = DEFAULT
--(
--mandant_id              SMALLINT NOT NULL,
--art_id                  INTEGER NOT NULL,
--vw_id                   BYTEINT,
--sm_id                   BYTEINT,
--list_durchg_fg          BYTEINT,
--bezugsweg1_fg           BYTEINT,
--bezugsweg4_fg           BYTEINT,
--kdis0_fg                BYTEINT,
--kdis1_fg                BYTEINT,
--anzahl_markt_soll       INTEGER,
--anzahl_markt_listung    INTEGER,
--anzahl_markt_bezugsweg1 INTEGER,
--anzahl_markt_bezugsweg4 INTEGER,
--anzahl_markt_kdis0      INTEGER,
--anzahl_markt_kdis1      INTEGER,
--ksm_id                  VARCHAR(4)
--)
--PRIMARY INDEX (art_id)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
CREATE  TABLE DBP_ETL.sternchen_logik_tmp_1  (
mandant_id              SMALLINT NOT NULL,
art_id                  INTEGER NOT NULL,
vw_id                   BYTEINT,
sm_id                   BYTEINT,
list_durchg_fg          BYTEINT,
bezugsweg1_fg           BYTEINT,
bezugsweg4_fg           BYTEINT,
kdis0_fg                BYTEINT,
kdis1_fg                BYTEINT,
anzahl_markt_soll       INTEGER,
anzahl_markt_listung    INTEGER,
anzahl_markt_bezugsweg1 INTEGER,
anzahl_markt_bezugsweg4 INTEGER,
anzahl_markt_kdis0      INTEGER,
anzahl_markt_kdis1      INTEGER,
ksm_id                  VARCHAR(4)
)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_LOAD.sternchen_logik_tmp_1
--(
--mandant_id
--,art_id
--,vw_id
--,sm_id
--,list_durchg_fg
--,bezugsweg1_fg
--,bezugsweg4_fg
--,kdis0_fg
--,kdis1_fg
--,anzahl_markt_soll
--,anzahl_markt_listung
--,anzahl_markt_bezugsweg1
--,anzahl_markt_bezugsweg4
--,anzahl_markt_kdis0
--,anzahl_markt_kdis1
--,ksm_id
--)
--SELECT
--dt_1.mandant_id
--,dt_2.art_id
--,dt_1.vw_id
--,dt_1.sm_id
--,(CASE WHEN dt_2.s_lstg = dt_1.wup_anz THEN 1 ELSE 0 END) AS list_durchg_fg
--,(CASE WHEN dt_2.s_bzwg1 = dt_2.s_lstg THEN 1 ELSE 0 END) AS bezugsweg1_fg
--,(CASE WHEN dt_2.s_bzwg4 = dt_2.s_lstg THEN 1 ELSE 0 END) AS bezugsweg4_fg
--,(CASE WHEN dt_2.s_kdis0 = dt_2.s_lstg THEN 1 ELSE 0 END) AS kdis0_fg
--,(CASE WHEN dt_2.s_kdis1 = dt_2.s_lstg THEN 1 ELSE 0 END) AS kdis1_fg
--,ZeroIfNull(dt_1.wup_anz) AS anzahl_markt_soll
--,ZeroIfNull(dt_2.s_lstg)  AS anzahl_markt_listing
--,ZeroIfNull(dt_2.s_bzwg1) AS anzahl_markt_bezugsweg1
--,ZeroIfNull(dt_2.s_bzwg4) AS anzahl_markt_bezugsweg4
--,ZeroIfNull(dt_2.s_kdis0) AS anzahl_markt_kdis0
--,ZeroIfNull(dt_2.s_kdis1) AS anzahl_markt_kdis1
--,NULL AS ksm_id
--FROM
--(
--SELECT
--dt1_1.mandant_id
--,dt1_1.wg_id
--,dt1_1.sm_id
--,dt1_2.vw_id
--,Count(DISTINCT dt1_1.wup_id) AS wup_anz
--FROM DBX_DATA.sm_wup_wg_zu_per_1 dt1_1
--
--INNER JOIN DBX_DATA.wup_1 dt1_2
--ON dt1_2.mandant_id = dt1_1.mandant_id
--AND dt1_2.wup_id = dt1_1.wup_id
--AND dt1_2.nb_id = dt1_1.nb_id
--
--WHERE dt1_1.nb_id = 0
--AND DATE BETWEEN dt1_1.dat_von AND dt1_1.dat_bis
--AND DATE BETWEEN dt1_2.dat_von - 42 AND dt1_2.dat_bis
---- AND dt1_1.mandant_id=
--
--GROUP BY
--dt1_1.mandant_id
--,dt1_1.wg_id
--,dt1_1.sm_id
--,dt1_2.vw_id
--) AS dt_1
--
--INNER JOIN
--(
--SELECT
--dt2_1.mandant_id
--,dt2_1.art_id
--,dt2_1.wg_id
--,dt2_2.sm_id
--,dt2_2.vw_id
--,Sum(dt2_1.listung_id) AS s_lstg
--,Sum(dt2_1.listung_id * dt2_1.kdis) AS s_kdis
--,Sum(dt2_1.listung_id * (CASE WHEN dt2_1.bezugsweg_id = 4 THEN 1 ELSE 0 END)) AS s_bzwg4
--,Sum(dt2_1.listung_id * (CASE WHEN dt2_1.bezugsweg_id = 1 THEN 1 ELSE 0 END)) AS s_bzwg1
--,Sum(dt2_1.listung_id * (CASE WHEN dt2_1.kdis = 0 THEN 1 ELSE 0 END)) AS s_kdis0
--,Sum(dt2_1.listung_id * dt2_1.kdis) AS s_kdis1
--,Count(dt2_1.wup_id) AS c_wup_id
--FROM
--(
--SELECT
--dt2_1_1.mandant_id
--,dt2_1_1.art_id
--,dt2_1_1.wup_id
--,dt2_1_2.wg_id
--,dt2_1_1.kdis
--,dt2_1_1.listung_id
--,dt2_1_1.bezugsweg_id
--FROM DBX_DATA.art_wup_zu_per_1 dt2_1_1
--
--INNER JOIN DBX_DATA.art_wg_zu_per_1 dt2_1_2
--ON dt2_1_1.mandant_id = dt2_1_2.mandant_id
--AND dt2_1_1.art_id = dt2_1_2.art_id
--
--WHERE dt2_1_2.arthiertyp_id = 2
--AND DATE BETWEEN dt2_1_2.dat_von AND dt2_1_2.dat_bis
--AND DATE BETWEEN dt2_1_1.dat_von AND dt2_1_1.dat_bis
--
--GROUP BY
--dt2_1_1.mandant_id
--,dt2_1_1.art_id
--,dt2_1_1.wup_id
--,dt2_1_2.wg_id
--,dt2_1_1.kdis
--,dt2_1_1.listung_id
--,dt2_1_1.bezugsweg_id
--) dt2_1
--
--INNER JOIN
--(
--SELECT
--dt2_2_1.mandant_id
--,dt2_2_1.wup_id
--,dt2_2_1.wg_id
--,dt2_2_1.sm_id
--,dt2_2_2.vw_id
--FROM DBX_DATA.sm_wup_wg_zu_per_1 dt2_2_1
--
--INNER JOIN DBX_DATA.wup_1 dt2_2_2
--ON dt2_2_2.mandant_id = dt2_2_1.mandant_id
--AND dt2_2_2.wup_id = dt2_2_1.wup_id
--AND dt2_2_2.nb_id = dt2_2_1.nb_id
--
--WHERE dt2_2_1.nb_id = 0
--AND DATE BETWEEN dt2_2_1.dat_von AND dt2_2_1.dat_bis
--AND DATE BETWEEN dt2_2_2.dat_von - 42 AND dt2_2_2.dat_bis
--
--GROUP BY
--dt2_2_1.mandant_id
--,dt2_2_1.wup_id
--,dt2_2_1.wg_id
--,dt2_2_1.sm_id
--,dt2_2_2.vw_id
--) AS dt2_2
--ON dt2_1.mandant_id = dt2_2.mandant_id
--AND dt2_1.wup_id = dt2_2.wup_id
--AND dt2_1.wg_id = dt2_2.wg_id
--
--GROUP BY
--dt2_1.mandant_id
--,dt2_1.art_id
--,dt2_1.wg_id
--,dt2_2.sm_id
--,dt2_2.vw_id
--) AS dt_2
--ON dt_1.mandant_id = dt_2.mandant_id
--AND dt_1.wg_id = dt_2.wg_id
--AND dt_1.sm_id = dt_2.sm_id
--AND dt_1.vw_id = dt_2.vw_id
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
INSERT INTO DBP_ETL.sternchen_logik_tmp_1
(
mandant_id
,art_id
,vw_id
,sm_id
,list_durchg_fg
,bezugsweg1_fg
,bezugsweg4_fg
,kdis0_fg
,kdis1_fg
,anzahl_markt_soll
,anzahl_markt_listung
,anzahl_markt_bezugsweg1
,anzahl_markt_bezugsweg4
,anzahl_markt_kdis0
,anzahl_markt_kdis1
,ksm_id
)
SELECT
dt_1.mandant_id
,dt_2.art_id
,dt_1.vw_id
,dt_1.sm_id
,(CASE WHEN dt_2.s_lstg = dt_1.wup_anz THEN 1 ELSE 0 END) AS list_durchg_fg
,(CASE WHEN dt_2.s_bzwg1 = dt_2.s_lstg THEN 1 ELSE 0 END) AS bezugsweg1_fg
,(CASE WHEN dt_2.s_bzwg4 = dt_2.s_lstg THEN 1 ELSE 0 END) AS bezugsweg4_fg
,(CASE WHEN dt_2.s_kdis0 = dt_2.s_lstg THEN 1 ELSE 0 END) AS kdis0_fg
,(CASE WHEN dt_2.s_kdis1 = dt_2.s_lstg THEN 1 ELSE 0 END) AS kdis1_fg
,ZeroIfNull(dt_1.wup_anz) AS anzahl_markt_soll
,ZeroIfNull(dt_2.s_lstg)  AS anzahl_markt_listing
,ZeroIfNull(dt_2.s_bzwg1) AS anzahl_markt_bezugsweg1
,ZeroIfNull(dt_2.s_bzwg4) AS anzahl_markt_bezugsweg4
,ZeroIfNull(dt_2.s_kdis0) AS anzahl_markt_kdis0
,ZeroIfNull(dt_2.s_kdis1) AS anzahl_markt_kdis1
,NULL AS ksm_id
FROM
(
SELECT
dt1_1.mandant_id
,dt1_1.wg_id
,dt1_1.sm_id
,dt1_2.vw_id
,Count(DISTINCT dt1_1.wup_id) AS wup_anz
FROM DBP_DATA.sm_wup_wg_zu_per_1 dt1_1

INNER JOIN DBP_DATA.wup_1 dt1_2
ON dt1_2.mandant_id = dt1_1.mandant_id
AND dt1_2.wup_id = dt1_1.wup_id
AND dt1_2.nb_id = dt1_1.nb_id

WHERE dt1_1.nb_id = 0
AND CURRENT_DATE BETWEEN dt1_1.dat_von AND dt1_1.dat_bis
AND CURRENT_DATE BETWEEN dt1_2.dat_von - 42 AND dt1_2.dat_bis
-- AND dt1_1.mandant_id=

GROUP BY
dt1_1.mandant_id
,dt1_1.wg_id
,dt1_1.sm_id
,dt1_2.vw_id
) AS dt_1

INNER JOIN
(
SELECT
dt2_1.mandant_id
,dt2_1.art_id
,dt2_1.wg_id
,dt2_2.sm_id
,dt2_2.vw_id
,Sum(dt2_1.listung_id) AS s_lstg
,Sum(dt2_1.listung_id * dt2_1.kdis) AS s_kdis
,Sum(dt2_1.listung_id * (CASE WHEN dt2_1.bezugsweg_id = 4 THEN 1 ELSE 0 END)) AS s_bzwg4
,Sum(dt2_1.listung_id * (CASE WHEN dt2_1.bezugsweg_id = 1 THEN 1 ELSE 0 END)) AS s_bzwg1
,Sum(dt2_1.listung_id * (CASE WHEN dt2_1.kdis = 0 THEN 1 ELSE 0 END)) AS s_kdis0
,Sum(dt2_1.listung_id * dt2_1.kdis) AS s_kdis1
,Count(dt2_1.wup_id) AS c_wup_id
FROM
(
SELECT
dt2_1_1.mandant_id
,dt2_1_1.art_id
,dt2_1_1.wup_id
,dt2_1_2.wg_id
,dt2_1_1.kdis
,dt2_1_1.listung_id
,dt2_1_1.bezugsweg_id
FROM DBP_DATA.art_wup_zu_per_1 dt2_1_1

INNER JOIN DBP_DATA.art_wg_zu_per_1 dt2_1_2
ON dt2_1_1.mandant_id = dt2_1_2.mandant_id
AND dt2_1_1.art_id = dt2_1_2.art_id

WHERE dt2_1_2.arthiertyp_id = 2
AND CURRENT_DATE BETWEEN dt2_1_2.dat_von AND dt2_1_2.dat_bis
AND CURRENT_DATE BETWEEN dt2_1_1.dat_von AND dt2_1_1.dat_bis

GROUP BY
dt2_1_1.mandant_id
,dt2_1_1.art_id
,dt2_1_1.wup_id
,dt2_1_2.wg_id
,dt2_1_1.kdis
,dt2_1_1.listung_id
,dt2_1_1.bezugsweg_id
) dt2_1

INNER JOIN
(
SELECT
dt2_2_1.mandant_id
,dt2_2_1.wup_id
,dt2_2_1.wg_id
,dt2_2_1.sm_id
,dt2_2_2.vw_id
FROM DBP_DATA.sm_wup_wg_zu_per_1 dt2_2_1

INNER JOIN DBP_DATA.wup_1 dt2_2_2
ON dt2_2_2.mandant_id = dt2_2_1.mandant_id
AND dt2_2_2.wup_id = dt2_2_1.wup_id
AND dt2_2_2.nb_id = dt2_2_1.nb_id

WHERE dt2_2_1.nb_id = 0
AND CURRENT_DATE BETWEEN dt2_2_1.dat_von AND dt2_2_1.dat_bis
AND CURRENT_DATE BETWEEN dt2_2_2.dat_von - 42 AND dt2_2_2.dat_bis

GROUP BY
dt2_2_1.mandant_id
,dt2_2_1.wup_id
,dt2_2_1.wg_id
,dt2_2_1.sm_id
,dt2_2_2.vw_id
) AS dt2_2
ON dt2_1.mandant_id = dt2_2.mandant_id
AND dt2_1.wup_id = dt2_2.wup_id
AND dt2_1.wg_id = dt2_2.wg_id

GROUP BY
dt2_1.mandant_id
,dt2_1.art_id
,dt2_1.wg_id
,dt2_2.sm_id
,dt2_2.vw_id
) AS dt_2
ON dt_1.mandant_id = dt_2.mandant_id
AND dt_1.wg_id = dt_2.wg_id
AND dt_1.sm_id = dt_2.sm_id
AND dt_1.vw_id = dt_2.vw_id
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_LOAD.sternchen_logik_tmp_1
--(
--mandant_id
--,art_id
--,vw_id
--,sm_id
--,list_durchg_fg
--,bezugsweg1_fg
--,bezugsweg4_fg
--,kdis0_fg
--,kdis1_fg
--,anzahl_markt_soll
--,anzahl_markt_listung
--,anzahl_markt_bezugsweg1
--,anzahl_markt_bezugsweg4
--,anzahl_markt_kdis0
--,anzahl_markt_kdis1
--,ksm_id
--)
--SELECT
--        dt_1.mandant_id
--        ,dt_2.art_id
--        ,dt_1.vw_id
--        ,NULL AS sm_id
--        ,(CASE WHEN dt_2.s_lstg = dt_1.wup_anz THEN 1 ELSE 0 END) AS list_durchg_fg
--        ,(CASE WHEN dt_2.s_bzwg1 = dt_2.s_lstg THEN 1 ELSE 0 END) AS bezugsweg1_fg
--        ,(CASE WHEN dt_2.s_bzwg4 = dt_2.s_lstg THEN 1 ELSE 0 END) AS bezugsweg4_fg
--        ,(CASE WHEN dt_2.s_kdis0 = dt_2.s_lstg THEN 1 ELSE 0 END) AS kdis0_fg
--        ,(CASE WHEN dt_2.s_kdis1 = dt_2.s_lstg THEN 1 ELSE 0 END) AS kdis1_fg
--        ,ZeroIfNull(dt_1.wup_anz) AS anzahl_markt_soll
--        ,ZeroIfNull(dt_2.s_lstg)  AS anzahl_markt_listing
--        ,ZeroIfNull(dt_2.s_bzwg1) AS anzahl_markt_bezugsweg1
--        ,ZeroIfNull(dt_2.s_bzwg4) AS anzahl_markt_bezugsweg4
--        ,ZeroIfNull(dt_2.s_kdis0) AS anzahl_markt_kdis0
--        ,ZeroIfNull(dt_2.s_kdis1) AS anzahl_markt_kdis1
--        ,dt_1.ksm_id
--FROM
--(
--        SELECT
--        dt1_1.mandant_id
--        ,dt1_1.wg_id
--        ,dt1_1.ksm_id
--        ,dt1_2.vw_id
--        ,Count(DISTINCT dt1_1.wup_id) AS wup_anz
--        FROM DBX_DATA.sm_wup_wg_zu_per_1 dt1_1
--
--        INNER JOIN DBX_DATA.wup_1 dt1_2
--        ON dt1_2.mandant_id = dt1_1.mandant_id
--        AND dt1_2.wup_id = dt1_1.wup_id
--        AND dt1_2.nb_id = dt1_1.nb_id
--
--        WHERE dt1_1.nb_id = 0
--        AND DATE BETWEEN dt1_1.dat_von AND dt1_1.dat_bis
--        AND DATE BETWEEN dt1_2.dat_von - 42 AND dt1_2.dat_bis
--        -- AND dt1_1.mandant_id=
--
--        GROUP BY
--        dt1_1.mandant_id
--        ,dt1_1.wg_id
--        ,dt1_1.ksm_id
--        ,dt1_2.vw_id
--) AS dt_1
--
--INNER JOIN
--(
--        SELECT
--        dt2_1.mandant_id
--        ,dt2_1.art_id
--        ,dt2_1.wg_id
--        ,dt2_2.ksm_id
--        ,dt2_2.vw_id
--        ,Sum(dt2_1.listung_id) AS s_lstg
--        ,Sum(dt2_1.listung_id * dt2_1.kdis) AS s_kdis
--        ,Sum(dt2_1.listung_id * (CASE WHEN dt2_1.bezugsweg_id = 4 THEN 1 ELSE 0 END)) AS s_bzwg4
--        ,Sum(dt2_1.listung_id * (CASE WHEN dt2_1.bezugsweg_id = 1 THEN 1 ELSE 0 END)) AS s_bzwg1
--        ,Sum(dt2_1.listung_id * (CASE WHEN dt2_1.kdis = 0 THEN 1 ELSE 0 END)) AS s_kdis0
--        ,Sum(dt2_1.listung_id * dt2_1.kdis) AS s_kdis1
--        ,Count(dt2_1.wup_id) AS c_wup_id
--        FROM
--        (
--                SELECT
--                dt2_1_1.mandant_id
--                ,dt2_1_1.art_id
--                ,dt2_1_1.wup_id
--                ,dt2_1_2.wg_id
--                ,dt2_1_1.kdis
--                ,dt2_1_1.listung_id
--                ,dt2_1_1.bezugsweg_id
--                FROM DBX_DATA.art_wup_zu_per_1 dt2_1_1
--
--                INNER JOIN DBX_DATA.art_wg_zu_per_1 dt2_1_2
--                ON dt2_1_1.mandant_id = dt2_1_2.mandant_id
--                AND dt2_1_1.art_id = dt2_1_2.art_id
--
--                WHERE dt2_1_2.arthiertyp_id = 2
--                AND DATE BETWEEN dt2_1_2.dat_von AND dt2_1_2.dat_bis
--                AND DATE BETWEEN dt2_1_1.dat_von AND dt2_1_1.dat_bis
--
--                GROUP BY
--                dt2_1_1.mandant_id
--                ,dt2_1_1.art_id
--                ,dt2_1_1.wup_id
--                ,dt2_1_2.wg_id
--                ,dt2_1_1.kdis
--                ,dt2_1_1.listung_id
--                ,dt2_1_1.bezugsweg_id
--        ) dt2_1
--        INNER JOIN
--        (
--                SELECT
--                dt2_2_1.mandant_id
--                ,dt2_2_1.wup_id
--                ,dt2_2_1.wg_id
--                ,dt2_2_1.ksm_id
--                ,dt2_2_2.vw_id
--                FROM DBX_DATA.sm_wup_wg_zu_per_1 dt2_2_1
--
--                INNER JOIN DBX_DATA.wup_1 dt2_2_2
--                ON dt2_2_2.mandant_id = dt2_2_1.mandant_id
--                AND dt2_2_2.wup_id = dt2_2_1.wup_id
--                AND dt2_2_2.nb_id = dt2_2_1.nb_id
--
--                WHERE dt2_2_1.nb_id = 0
--                AND DATE BETWEEN dt2_2_1.dat_von AND dt2_2_1.dat_bis
--                AND DATE BETWEEN dt2_2_2.dat_von - 42 AND dt2_2_2.dat_bis
--
--                GROUP BY
--                dt2_2_1.mandant_id
--                ,dt2_2_1.wup_id
--                ,dt2_2_1.wg_id
--                ,dt2_2_1.ksm_id
--                ,dt2_2_2.vw_id
--        ) AS dt2_2
--        ON dt2_1.mandant_id = dt2_2.mandant_id
--        AND dt2_1.wup_id = dt2_2.wup_id
--        AND dt2_1.wg_id = dt2_2.wg_id
--
--        GROUP BY
--        dt2_1.mandant_id
--        ,dt2_1.art_id
--        ,dt2_1.wg_id
--        ,dt2_2.ksm_id
--        ,dt2_2.vw_id
--) AS dt_2
--ON dt_1.mandant_id = dt_2.mandant_id
--AND dt_1.wg_id = dt_2.wg_id
--AND dt_1.ksm_id = dt_2.ksm_id
--AND dt_1.vw_id = dt_2.vw_id
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
INSERT INTO DBP_ETL.sternchen_logik_tmp_1
(
mandant_id
,art_id
,vw_id
,sm_id
,list_durchg_fg
,bezugsweg1_fg
,bezugsweg4_fg
,kdis0_fg
,kdis1_fg
,anzahl_markt_soll
,anzahl_markt_listung
,anzahl_markt_bezugsweg1
,anzahl_markt_bezugsweg4
,anzahl_markt_kdis0
,anzahl_markt_kdis1
,ksm_id
)
SELECT
        dt_1.mandant_id
        ,dt_2.art_id
        ,dt_1.vw_id
        ,NULL AS sm_id
        ,(CASE WHEN dt_2.s_lstg = dt_1.wup_anz THEN 1 ELSE 0 END) AS list_durchg_fg
        ,(CASE WHEN dt_2.s_bzwg1 = dt_2.s_lstg THEN 1 ELSE 0 END) AS bezugsweg1_fg
        ,(CASE WHEN dt_2.s_bzwg4 = dt_2.s_lstg THEN 1 ELSE 0 END) AS bezugsweg4_fg
        ,(CASE WHEN dt_2.s_kdis0 = dt_2.s_lstg THEN 1 ELSE 0 END) AS kdis0_fg
        ,(CASE WHEN dt_2.s_kdis1 = dt_2.s_lstg THEN 1 ELSE 0 END) AS kdis1_fg
        ,ZeroIfNull(dt_1.wup_anz) AS anzahl_markt_soll
        ,ZeroIfNull(dt_2.s_lstg)  AS anzahl_markt_listing
        ,ZeroIfNull(dt_2.s_bzwg1) AS anzahl_markt_bezugsweg1
        ,ZeroIfNull(dt_2.s_bzwg4) AS anzahl_markt_bezugsweg4
        ,ZeroIfNull(dt_2.s_kdis0) AS anzahl_markt_kdis0
        ,ZeroIfNull(dt_2.s_kdis1) AS anzahl_markt_kdis1
        ,dt_1.ksm_id
FROM
(
        SELECT
        dt1_1.mandant_id
        ,dt1_1.wg_id
        ,dt1_1.ksm_id
        ,dt1_2.vw_id
        ,Count(DISTINCT dt1_1.wup_id) AS wup_anz
        FROM DBP_DATA.sm_wup_wg_zu_per_1 dt1_1

        INNER JOIN DBP_DATA.wup_1 dt1_2
        ON dt1_2.mandant_id = dt1_1.mandant_id
        AND dt1_2.wup_id = dt1_1.wup_id
        AND dt1_2.nb_id = dt1_1.nb_id

        WHERE dt1_1.nb_id = 0
        AND CURRENT_DATE BETWEEN dt1_1.dat_von AND dt1_1.dat_bis
        AND CURRENT_DATE BETWEEN dt1_2.dat_von - 42 AND dt1_2.dat_bis
        -- AND dt1_1.mandant_id=

        GROUP BY
        dt1_1.mandant_id
        ,dt1_1.wg_id
        ,dt1_1.ksm_id
        ,dt1_2.vw_id
) AS dt_1

INNER JOIN
(
        SELECT
        dt2_1.mandant_id
        ,dt2_1.art_id
        ,dt2_1.wg_id
        ,dt2_2.ksm_id
        ,dt2_2.vw_id
        ,Sum(dt2_1.listung_id) AS s_lstg
        ,Sum(dt2_1.listung_id * dt2_1.kdis) AS s_kdis
        ,Sum(dt2_1.listung_id * (CASE WHEN dt2_1.bezugsweg_id = 4 THEN 1 ELSE 0 END)) AS s_bzwg4
        ,Sum(dt2_1.listung_id * (CASE WHEN dt2_1.bezugsweg_id = 1 THEN 1 ELSE 0 END)) AS s_bzwg1
        ,Sum(dt2_1.listung_id * (CASE WHEN dt2_1.kdis = 0 THEN 1 ELSE 0 END)) AS s_kdis0
        ,Sum(dt2_1.listung_id * dt2_1.kdis) AS s_kdis1
        ,Count(dt2_1.wup_id) AS c_wup_id
        FROM
        (
                SELECT
                dt2_1_1.mandant_id
                ,dt2_1_1.art_id
                ,dt2_1_1.wup_id
                ,dt2_1_2.wg_id
                ,dt2_1_1.kdis
                ,dt2_1_1.listung_id
                ,dt2_1_1.bezugsweg_id
                FROM DBP_DATA.art_wup_zu_per_1 dt2_1_1

                INNER JOIN DBP_DATA.art_wg_zu_per_1 dt2_1_2
                ON dt2_1_1.mandant_id = dt2_1_2.mandant_id
                AND dt2_1_1.art_id = dt2_1_2.art_id

                WHERE dt2_1_2.arthiertyp_id = 2
                AND CURRENT_DATE BETWEEN dt2_1_2.dat_von AND dt2_1_2.dat_bis
                AND CURRENT_DATE BETWEEN dt2_1_1.dat_von AND dt2_1_1.dat_bis

                GROUP BY
                dt2_1_1.mandant_id
                ,dt2_1_1.art_id
                ,dt2_1_1.wup_id
                ,dt2_1_2.wg_id
                ,dt2_1_1.kdis
                ,dt2_1_1.listung_id
                ,dt2_1_1.bezugsweg_id
        ) dt2_1
        INNER JOIN
        (
                SELECT
                dt2_2_1.mandant_id
                ,dt2_2_1.wup_id
                ,dt2_2_1.wg_id
                ,dt2_2_1.ksm_id
                ,dt2_2_2.vw_id
                FROM DBP_DATA.sm_wup_wg_zu_per_1 dt2_2_1

                INNER JOIN DBP_DATA.wup_1 dt2_2_2
                ON dt2_2_2.mandant_id = dt2_2_1.mandant_id
                AND dt2_2_2.wup_id = dt2_2_1.wup_id
                AND dt2_2_2.nb_id = dt2_2_1.nb_id

                WHERE dt2_2_1.nb_id = 0
                AND CURRENT_DATE BETWEEN dt2_2_1.dat_von AND dt2_2_1.dat_bis
                AND CURRENT_DATE BETWEEN dt2_2_2.dat_von - 42 AND dt2_2_2.dat_bis

                GROUP BY
                dt2_2_1.mandant_id
                ,dt2_2_1.wup_id
                ,dt2_2_1.wg_id
                ,dt2_2_1.ksm_id
                ,dt2_2_2.vw_id
        ) AS dt2_2
        ON dt2_1.mandant_id = dt2_2.mandant_id
        AND dt2_1.wup_id = dt2_2.wup_id
        AND dt2_1.wg_id = dt2_2.wg_id

        GROUP BY
        dt2_1.mandant_id
        ,dt2_1.art_id
        ,dt2_1.wg_id
        ,dt2_2.ksm_id
        ,dt2_2.vw_id
) AS dt_2
ON dt_1.mandant_id = dt_2.mandant_id
AND dt_1.wg_id = dt_2.wg_id
AND dt_1.ksm_id = dt_2.ksm_id
AND dt_1.vw_id = dt_2.vw_id
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBX_DATA.sternchen_logik_1 ALL;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
DELETE FROM DBP_DATA.sternchen_logik_1;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_DATA.sternchen_logik_1
--(
--        mandant_id
--        ,art_id
--        ,vw_id
--        ,sm_id
--        ,list_durchg_fg
--        ,bezugsweg1_fg
--        ,bezugsweg4_fg
--        ,kdis0_fg
--        ,kdis1_fg
--        ,anzahl_markt_soll
--        ,anzahl_markt_listung
--        ,anzahl_markt_bezugsweg1
--        ,anzahl_markt_bezugsweg4
--        ,anzahl_markt_kdis0
--        ,anzahl_markt_kdis1
--        ,dat_von
--        ,dat_bis
--        ,ksm_id
--)
--SELECT
--        mandant_id
--        ,art_id
--        ,vw_id
--        ,COALESCE(sm_id,-9) AS sm_id
--        ,list_durchg_fg
--        ,bezugsweg1_fg
--        ,bezugsweg4_fg
--        ,kdis0_fg
--        ,kdis1_fg
--        ,anzahl_markt_soll
--        ,anzahl_markt_listung
--        ,anzahl_markt_bezugsweg1
--        ,anzahl_markt_bezugsweg4
--        ,anzahl_markt_kdis0
--        ,anzahl_markt_kdis1
--        ,DATE AS dat_von
--        ,80991231 AS dat_bis
--        ,COALESCE(ksm_id,'-9') AS ksm_id
--FROM DBX_LOAD.sternchen_logik_tmp_1
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
INSERT INTO DBP_DATA.sternchen_logik_1
(
        mandant_id
        ,art_id
        ,vw_id
        ,sm_id
        ,list_durchg_fg
        ,bezugsweg1_fg
        ,bezugsweg4_fg
        ,kdis0_fg
        ,kdis1_fg
        ,anzahl_markt_soll
        ,anzahl_markt_listung
        ,anzahl_markt_bezugsweg1
        ,anzahl_markt_bezugsweg4
        ,anzahl_markt_kdis0
        ,anzahl_markt_kdis1
        ,dat_von
        ,dat_bis
        ,ksm_id
)
SELECT
        mandant_id
        ,art_id
        ,vw_id
        ,COALESCE(sm_id,-9) AS sm_id
        ,list_durchg_fg
        ,bezugsweg1_fg
        ,bezugsweg4_fg
        ,kdis0_fg
        ,kdis1_fg
        ,anzahl_markt_soll
        ,anzahl_markt_listung
        ,anzahl_markt_bezugsweg1
        ,anzahl_markt_bezugsweg4
        ,anzahl_markt_kdis0
        ,anzahl_markt_kdis1
        ,CURRENT_DATE AS dat_von
        , to_date('9999-12-31','YYYY-MM_1-DD') AS dat_bis
        ,COALESCE(ksm_id,'-9') AS ksm_id
FROM DBP_ETL.sternchen_logik_tmp_1
;

delete from dbp_data.sternchen_logik_1 where sm_id = -1 ; 

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE dbp_load.sternchen_logik_kreis_tmp_1;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
DROP TABLE IF EXISTS DBP_ETL.sternchen_logik_kreis_tmp_1;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
--original statement
--CREATE SET TABLE dbp_load.sternchen_logik_kreis_tmp_1,
--NO FALLBACK,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL,
--CHECKSUM = DEFAULT
--(
--mandant_id              SMALLINT NOT NULL,
--art_id                  INTEGER NOT NULL,
--kreistyp_gruppe_id      CHAR(4),
--list_durchg_fg          BYTEINT,
--bezugsweg1_fg           BYTEINT,
--bezugsweg4_fg           BYTEINT,
--kdis0_fg                BYTEINT,
--kdis1_fg                BYTEINT,
--anzahl_markt_soll       INTEGER,
--anzahl_markt_listung    INTEGER,
--anzahl_markt_bezugsweg1 INTEGER,
--anzahl_markt_bezugsweg4 INTEGER,
--anzahl_markt_kdis0      INTEGER,
--anzahl_markt_kdis1      INTEGER
--)
--PRIMARY INDEX (art_id);
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
CREATE  TABLE DBP_ETL.sternchen_logik_kreis_tmp_1  (
mandant_id              SMALLINT NOT NULL,
art_id                  INTEGER NOT NULL,
kreistyp_gruppe_id      CHAR(4),
list_durchg_fg          BYTEINT,
bezugsweg1_fg           BYTEINT,
bezugsweg4_fg           BYTEINT,
kdis0_fg                BYTEINT,
kdis1_fg                BYTEINT,
anzahl_markt_soll       INTEGER,
anzahl_markt_listung    INTEGER,
anzahl_markt_bezugsweg1 INTEGER,
anzahl_markt_bezugsweg4 INTEGER,
anzahl_markt_kdis0      INTEGER,
anzahl_markt_kdis1      INTEGER
)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO dbp_load.sternchen_logik_kreis_tmp_1
--(
--mandant_id
--,art_id
--,kreistyp_gruppe_id
--,list_durchg_fg
--,bezugsweg1_fg
--,bezugsweg4_fg
--,kdis0_fg
--,kdis1_fg
--,anzahl_markt_soll
--,anzahl_markt_listung
--,anzahl_markt_bezugsweg1
--,anzahl_markt_bezugsweg4
--,anzahl_markt_kdis0
--,anzahl_markt_kdis1
--)
--SELECT
--dt_1.mandant_id
--,dt_2.art_id
--,dt_1.kreistyp_gruppe_id
--,(CASE WHEN dt_2.s_lstg = dt_1.wup_anz THEN 1 ELSE 0 END) AS list_durchg_fg
--,(CASE WHEN dt_2.s_bzwg1 = dt_2.s_lstg THEN 1 ELSE 0 END) AS bezugsweg1_fg
--,(CASE WHEN dt_2.s_bzwg4 = dt_2.s_lstg THEN 1 ELSE 0 END) AS bezugsweg4_fg
--,(CASE WHEN dt_2.s_kdis0 = dt_2.s_lstg THEN 1 ELSE 0 END) AS kdis0_fg
--,(CASE WHEN dt_2.s_kdis1 = dt_2.s_lstg THEN 1 ELSE 0 END) AS kdis1_fg
--,ZEROIFNULL(dt_1.wup_anz) AS anzahl_markt_soll
--,ZEROIFNULL(dt_2.s_lstg)  AS anzahl_markt_listing
--,ZEROIFNULL(dt_2.s_bzwg1) AS anzahl_markt_bezugsweg1
--,ZEROIFNULL(dt_2.s_bzwg4) AS anzahl_markt_bezugsweg4
--,ZEROIFNULL(dt_2.s_kdis0) AS anzahl_markt_kdis0
--,ZEROIFNULL(dt_2.s_kdis1) AS anzahl_markt_kdis1
--FROM
--(
--SELECT
--dt1_1.mandant_id
--,dt1_1.wg_id
--,dt1_2.kreistyp_gruppe_id
--,COUNT(DISTINCT dt1_1.wup_id) AS wup_anz
--FROM dbp_data.sm_wup_wg_zu_per_1 dt1_1
--
--INNER JOIN dbp_data.wup_1 dt1_2
--ON dt1_2.mandant_id = dt1_1.mandant_id
--AND dt1_2.wup_id = dt1_1.wup_id
--AND dt1_2.nb_id = dt1_1.nb_id
--
--WHERE dt1_1.nb_id = 0
--AND dt1_1.sm_id BETWEEN 1 AND 6
--AND DATE BETWEEN dt1_1.dat_von AND dt1_1.dat_bis
--AND DATE BETWEEN dt1_2.dat_von - 42 AND dt1_2.dat_bis
--
--GROUP BY
--dt1_1.mandant_id
--,dt1_1.wg_id
--,dt1_2.kreistyp_gruppe_id
--) AS dt_1
--
--INNER JOIN
--(
--SELECT
--dt2_1.mandant_id
--,dt2_1.art_id
--,dt2_1.wg_id
--,dt2_2.kreistyp_gruppe_id
--,SUM(dt2_1.listung_id) AS s_lstg
--,SUM(dt2_1.listung_id * dt2_1.kdis) AS s_kdis
--,SUM(dt2_1.listung_id * (CASE WHEN dt2_1.bezugsweg_id = 4 THEN 1 ELSE 0 END)) AS s_bzwg4
--,SUM(dt2_1.listung_id * (CASE WHEN dt2_1.bezugsweg_id = 1 THEN 1 ELSE 0 END)) AS s_bzwg1
--,SUM(dt2_1.listung_id * (CASE WHEN dt2_1.kdis = 0 THEN 1 ELSE 0 END)) AS s_kdis0
--,SUM(dt2_1.listung_id * dt2_1.kdis) AS s_kdis1
--,COUNT(dt2_1.wup_id) AS c_wup_id
--FROM
--(
--SELECT
--dt2_1_1.mandant_id
--,dt2_1_1.art_id
--,dt2_1_1.wup_id
--,dt2_1_2.wg_id
--,dt2_1_1.kdis
--,dt2_1_1.listung_id
--,dt2_1_1.bezugsweg_id
--FROM dbp_data.art_wup_zu_per_1 dt2_1_1
--
--INNER JOIN dbp_data.art_wg_zu_per_1 dt2_1_2
--ON dt2_1_1.mandant_id = dt2_1_2.mandant_id
--AND dt2_1_1.art_id = dt2_1_2.art_id
--
--WHERE dt2_1_2.arthiertyp_id = 2
--AND DATE BETWEEN dt2_1_2.dat_von AND dt2_1_2.dat_bis
--AND DATE BETWEEN dt2_1_1.dat_von AND dt2_1_1.dat_bis
--
--GROUP BY
--dt2_1_1.mandant_id
--,dt2_1_1.art_id
--,dt2_1_1.wup_id
--,dt2_1_2.wg_id
--,dt2_1_1.kdis
--,dt2_1_1.listung_id
--,dt2_1_1.bezugsweg_id
--) dt2_1
--
--INNER JOIN
--(
--SELECT
--dt2_2_1.mandant_id
--,dt2_2_1.wup_id
--,dt2_2_1.wg_id
--,dt2_2_2.kreistyp_gruppe_id
--FROM dbp_data.sm_wup_wg_zu_per_1 dt2_2_1
--
--INNER JOIN dbp_data.wup_1 dt2_2_2
--ON dt2_2_2.mandant_id = dt2_2_1.mandant_id
--AND dt2_2_2.wup_id = dt2_2_1.wup_id
--AND dt2_2_2.nb_id = dt2_2_1.nb_id
--
--WHERE dt2_2_1.nb_id = 0
--AND dt2_2_1.sm_id BETWEEN 1 AND 6
--AND DATE BETWEEN dt2_2_1.dat_von AND dt2_2_1.dat_bis
--AND DATE BETWEEN dt2_2_2.dat_von - 42 AND dt2_2_2.dat_bis
--
--GROUP BY
--dt2_2_1.mandant_id
--,dt2_2_1.wup_id
--,dt2_2_1.wg_id
--,dt2_2_2.kreistyp_gruppe_id
--) AS dt2_2
--ON dt2_1.mandant_id = dt2_2.mandant_id
--AND dt2_1.wup_id = dt2_2.wup_id
--AND dt2_1.wg_id = dt2_2.wg_id
--
--GROUP BY
--dt2_1.mandant_id
--,dt2_1.art_id
--,dt2_1.wg_id
--,dt2_2.kreistyp_gruppe_id
--) AS dt_2
--ON dt_1.mandant_id = dt_2.mandant_id
--AND dt_1.wg_id = dt_2.wg_id
--AND dt_1.kreistyp_gruppe_id = dt_2.kreistyp_gruppe_id
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
INSERT INTO DBP_ETL.sternchen_logik_kreis_tmp_1
(
mandant_id
,art_id
,kreistyp_gruppe_id
,list_durchg_fg
,bezugsweg1_fg
,bezugsweg4_fg
,kdis0_fg
,kdis1_fg
,anzahl_markt_soll
,anzahl_markt_listung
,anzahl_markt_bezugsweg1
,anzahl_markt_bezugsweg4
,anzahl_markt_kdis0
,anzahl_markt_kdis1
)
SELECT
dt_1.mandant_id
,dt_2.art_id
,dt_1.kreistyp_gruppe_id
,(CASE WHEN dt_2.s_lstg = dt_1.wup_anz THEN 1 ELSE 0 END) AS list_durchg_fg
,(CASE WHEN dt_2.s_bzwg1 = dt_2.s_lstg THEN 1 ELSE 0 END) AS bezugsweg1_fg
,(CASE WHEN dt_2.s_bzwg4 = dt_2.s_lstg THEN 1 ELSE 0 END) AS bezugsweg4_fg
,(CASE WHEN dt_2.s_kdis0 = dt_2.s_lstg THEN 1 ELSE 0 END) AS kdis0_fg
,(CASE WHEN dt_2.s_kdis1 = dt_2.s_lstg THEN 1 ELSE 0 END) AS kdis1_fg
,ZEROIFNULL(dt_1.wup_anz) AS anzahl_markt_soll
,ZEROIFNULL(dt_2.s_lstg)  AS anzahl_markt_listing
,ZEROIFNULL(dt_2.s_bzwg1) AS anzahl_markt_bezugsweg1
,ZEROIFNULL(dt_2.s_bzwg4) AS anzahl_markt_bezugsweg4
,ZEROIFNULL(dt_2.s_kdis0) AS anzahl_markt_kdis0
,ZEROIFNULL(dt_2.s_kdis1) AS anzahl_markt_kdis1
FROM
(
SELECT
dt1_1.mandant_id
,dt1_1.wg_id
,dt1_2.kreistyp_gruppe_id
,COUNT(DISTINCT dt1_1.wup_id) AS wup_anz
FROM dbp_data.sm_wup_wg_zu_per_1 dt1_1

INNER JOIN dbp_data.wup_1 dt1_2
ON dt1_2.mandant_id = dt1_1.mandant_id
AND dt1_2.wup_id = dt1_1.wup_id
AND dt1_2.nb_id = dt1_1.nb_id

WHERE dt1_1.nb_id = 0
AND dt1_1.sm_id BETWEEN 1 AND 6
AND CURRENT_DATE BETWEEN dt1_1.dat_von AND dt1_1.dat_bis
AND CURRENT_DATE BETWEEN dt1_2.dat_von - 42 AND dt1_2.dat_bis

GROUP BY
dt1_1.mandant_id
,dt1_1.wg_id
,dt1_2.kreistyp_gruppe_id
) AS dt_1

INNER JOIN
(
SELECT
dt2_1.mandant_id
,dt2_1.art_id
,dt2_1.wg_id
,dt2_2.kreistyp_gruppe_id
,SUM(dt2_1.listung_id) AS s_lstg
,SUM(dt2_1.listung_id * dt2_1.kdis) AS s_kdis
,SUM(dt2_1.listung_id * (CASE WHEN dt2_1.bezugsweg_id = 4 THEN 1 ELSE 0 END)) AS s_bzwg4
,SUM(dt2_1.listung_id * (CASE WHEN dt2_1.bezugsweg_id = 1 THEN 1 ELSE 0 END)) AS s_bzwg1
,SUM(dt2_1.listung_id * (CASE WHEN dt2_1.kdis = 0 THEN 1 ELSE 0 END)) AS s_kdis0
,SUM(dt2_1.listung_id * dt2_1.kdis) AS s_kdis1
,COUNT(dt2_1.wup_id) AS c_wup_id
FROM
(
SELECT
dt2_1_1.mandant_id
,dt2_1_1.art_id
,dt2_1_1.wup_id
,dt2_1_2.wg_id
,dt2_1_1.kdis
,dt2_1_1.listung_id
,dt2_1_1.bezugsweg_id
FROM dbp_data.art_wup_zu_per_1 dt2_1_1

INNER JOIN dbp_data.art_wg_zu_per_1 dt2_1_2
ON dt2_1_1.mandant_id = dt2_1_2.mandant_id
AND dt2_1_1.art_id = dt2_1_2.art_id

WHERE dt2_1_2.arthiertyp_id = 2
AND CURRENT_DATE BETWEEN dt2_1_2.dat_von AND dt2_1_2.dat_bis
AND CURRENT_DATE BETWEEN dt2_1_1.dat_von AND dt2_1_1.dat_bis

GROUP BY
dt2_1_1.mandant_id
,dt2_1_1.art_id
,dt2_1_1.wup_id
,dt2_1_2.wg_id
,dt2_1_1.kdis
,dt2_1_1.listung_id
,dt2_1_1.bezugsweg_id
) dt2_1

INNER JOIN
(
SELECT
dt2_2_1.mandant_id
,dt2_2_1.wup_id
,dt2_2_1.wg_id
,dt2_2_2.kreistyp_gruppe_id
FROM dbp_data.sm_wup_wg_zu_per_1 dt2_2_1

INNER JOIN dbp_data.wup_1 dt2_2_2
ON dt2_2_2.mandant_id = dt2_2_1.mandant_id
AND dt2_2_2.wup_id = dt2_2_1.wup_id
AND dt2_2_2.nb_id = dt2_2_1.nb_id

WHERE dt2_2_1.nb_id = 0
AND dt2_2_1.sm_id BETWEEN 1 AND 6
AND CURRENT_DATE BETWEEN dt2_2_1.dat_von AND dt2_2_1.dat_bis
AND CURRENT_DATE BETWEEN dt2_2_2.dat_von - 42 AND dt2_2_2.dat_bis

GROUP BY
dt2_2_1.mandant_id
,dt2_2_1.wup_id
,dt2_2_1.wg_id
,dt2_2_2.kreistyp_gruppe_id
) AS dt2_2
ON dt2_1.mandant_id = dt2_2.mandant_id
AND dt2_1.wup_id = dt2_2.wup_id
AND dt2_1.wg_id = dt2_2.wg_id

GROUP BY
dt2_1.mandant_id
,dt2_1.art_id
,dt2_1.wg_id
,dt2_2.kreistyp_gruppe_id
) AS dt_2
ON dt_1.mandant_id = dt_2.mandant_id
AND dt_1.wg_id = dt_2.wg_id
AND dt_1.kreistyp_gruppe_id = dt_2.kreistyp_gruppe_id
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM dbp_data.sternchen_logik_kreis_1 ALL;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
DELETE FROM dbp_data.sternchen_logik_kreis_1;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO dbp_data.sternchen_logik_kreis_1
--(
--        mandant_id
--        ,art_id
--        ,kreistyp_gruppe_id
--        ,list_durchg_fg
--        ,bezugsweg1_fg
--        ,bezugsweg4_fg
--        ,kdis0_fg
--        ,kdis1_fg
--        ,anzahl_markt_soll
--        ,anzahl_markt_listung
--        ,anzahl_markt_bezugsweg1
--        ,anzahl_markt_bezugsweg4
--        ,anzahl_markt_kdis0
--        ,anzahl_markt_kdis1
--        ,dat_von
--        ,dat_bis
--)
--SELECT
--        mandant_id
--        ,art_id
--        ,kreistyp_gruppe_id
--        ,list_durchg_fg
--        ,bezugsweg1_fg
--        ,bezugsweg4_fg
--        ,kdis0_fg
--        ,kdis1_fg
--        ,anzahl_markt_soll
--        ,anzahl_markt_listung
--        ,anzahl_markt_bezugsweg1
--        ,anzahl_markt_bezugsweg4
--        ,anzahl_markt_kdis0
--        ,anzahl_markt_kdis1
--        ,DATE AS dat_von
--        ,80991231 AS dat_bis
--FROM dbp_load.sternchen_logik_kreis_tmp_1
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
INSERT INTO dbp_data.sternchen_logik_kreis_1
(
        mandant_id
        ,art_id
        ,kreistyp_gruppe_id
        ,list_durchg_fg
        ,bezugsweg1_fg
        ,bezugsweg4_fg
        ,kdis0_fg
        ,kdis1_fg
        ,anzahl_markt_soll
        ,anzahl_markt_listung
        ,anzahl_markt_bezugsweg1
        ,anzahl_markt_bezugsweg4
        ,anzahl_markt_kdis0
        ,anzahl_markt_kdis1
        ,dat_von
        ,dat_bis
)
SELECT
        mandant_id
        ,art_id
        ,kreistyp_gruppe_id
        ,list_durchg_fg
        ,bezugsweg1_fg
        ,bezugsweg4_fg
        ,kdis0_fg
        ,kdis1_fg
        ,anzahl_markt_soll
        ,anzahl_markt_listung
        ,anzahl_markt_bezugsweg1
        ,anzahl_markt_bezugsweg4
        ,anzahl_markt_kdis0
        ,anzahl_markt_kdis1
        ,CURRENT_DATE AS dat_von
        , to_date('9999-12-31','YYYY-MM_1-DD') AS dat_bis
FROM DBP_ETL.sternchen_logik_kreis_tmp_1
;

