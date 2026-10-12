--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
--original statement
--CREATE SET TABLE DBX_LOAD.gruppe_gruppe_zu_tmp,
--NO FALLBACK,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL,
--CHECKSUM = DEFAULT
--(
--gruppe_parent_id INTEGER NOT NULL,
--gruppe_id INTEGER NOT NULL,
--herkunft CHAR(1) NOT NULL
--)
--PRIMARY INDEX NUPI_gruppe_gruppe_zu_tmp (gruppe_id);
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
CREATE  TABLE DBP_ETL.gruppe_gruppe_zu_tmp  (
gruppe_parent_id INTEGER NOT NULL,
gruppe_id INTEGER NOT NULL,
herkunft CHAR(1) NOT NULL
)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_LOAD.gruppe_gruppe_zu_tmp
--(
--gruppe_parent_id
--,gruppe_id
--,herkunft
--)
--SELECT
--gruppe_parent_id
--,gruppe_id
--,'s' AS herkunft
--FROM DBX_SECURITY.gruppe_gruppe_zu
--UNION
--SELECT
--gruppe_parent_id
--,gruppe_id
--,'d' AS herkunft
--FROM DBX_DIALOG.d_gruppe_gruppe_zu
--
--WHERE loesch_fg = 0
--
--GROUP BY 1,2,3
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
INSERT INTO DBP_ETL.gruppe_gruppe_zu_tmp
(
gruppe_parent_id
,gruppe_id
,herkunft
)
SELECT
gruppe_parent_id
,gruppe_id
,'s' AS herkunft
FROM DBX_SECURITY.gruppe_gruppe_zu
UNION
SELECT
gruppe_parent_id
,gruppe_id
,'d' AS herkunft
FROM DBX_DIALOG.d_gruppe_gruppe_zu

WHERE loesch_fg = 0

GROUP BY 1,2,3
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBX_SECURITY.gruppe_user_zu
--WHERE (TRIM(UPPER(user_id))) IN
--(
--SELECT
--TRIM(UPPER(user_id))
--FROM DBX_DIALOG.d_gruppe_user_zu
--)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
DELETE FROM DBX_SECURITY.gruppe_user_zu
WHERE (TRIM(UPPER(user_id))) IN
(
SELECT
TRIM(UPPER(user_id))
FROM DBX_DIALOG.d_gruppe_user_zu
)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBX_SECURITY.gruppe_gruppe_zu
--WHERE (gruppe_id, gruppe_parent_id) IN
--(
--SELECT
--gruppe_id
--,gruppe_parent_id
--FROM DBX_DIALOG.d_gruppe_gruppe_zu
--WHERE loesch_fg = 1
--)
--AND (gruppe_id) NOT IN /*darf nicht von einer darunterliegenden Hierarchiestufe ref. werden*/
--(
--SELECT
--gruppe_parent_id
--FROM DBX_SECURITY.gruppe_gruppe_zu
--)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
DELETE FROM DBX_SECURITY.gruppe_gruppe_zu
WHERE (gruppe_id, gruppe_parent_id) IN
(
SELECT
gruppe_id
,gruppe_parent_id
FROM DBX_DIALOG.d_gruppe_gruppe_zu
WHERE loesch_fg = 1
)
AND (gruppe_id) NOT IN /*darf nicht von einer darunterliegenden Hierarchiestufe ref. werden*/
(
SELECT
gruppe_parent_id
FROM DBX_SECURITY.gruppe_gruppe_zu
)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBX_SECURITY.gruppe_zek_zu
--WHERE (gruppe_id, mandant_id, zek_id, alle_zek_fg) IN /*Einzelne Zuordnung*/
--(
--SELECT
--gruppe_id
--,mandant_id
--,zek_id
--,alle_zek_fg
--FROM DBX_DIALOG.d_gruppe_zek_zu
--WHERE loesch_fg   = 1
--AND alle_zek_fg = 0
--)
--OR (gruppe_id, mandant_id, alle_zek_fg) IN /*alle Zuordnungen eines Mandanten*/
--(
--SELECT
--gruppe_id
--,mandant_id
--,alle_zek_fg
--FROM DBX_DIALOG.d_gruppe_zek_zu
--WHERE loesch_fg   = 1
--AND alle_zek_fg = 1
--)
--OR (mandant_id, zek_id) NOT IN /*falls Zeks in den Stammdaten geloescht*/
--(
--SELECT
--mandant_id
--,zek_id
--FROM DBX_DATA.zek
--)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
DELETE FROM DBX_SECURITY.gruppe_zek_zu
WHERE (gruppe_id, mandant_id, zek_id, alle_zek_fg) IN /*Einzelne Zuordnung*/
(
SELECT
gruppe_id
,mandant_id
,zek_id
,alle_zek_fg
FROM DBX_DIALOG.d_gruppe_zek_zu
WHERE loesch_fg   = 1
AND alle_zek_fg = 0
)
OR (gruppe_id, mandant_id, alle_zek_fg) IN /*alle Zuordnungen eines Mandanten*/
(
SELECT
gruppe_id
,mandant_id
,alle_zek_fg
FROM DBX_DIALOG.d_gruppe_zek_zu
WHERE loesch_fg   = 1
AND alle_zek_fg = 1
)
OR (mandant_id, zek_id) NOT IN /*falls Zeks in den Stammdaten geloescht*/
(
SELECT
mandant_id
,zek_id
FROM DBP_DATA.zek
)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBX_SECURITY.gruppe
--WHERE (gruppe_id) NOT IN
--(SELECT gruppe_id FROM DBX_SECURITY.gruppe_user_zu)
--AND (gruppe_id) NOT IN
--(SELECT gruppe_id FROM DBX_SECURITY.gruppe_zek_zu)
--AND (gruppe_id) NOT IN
--(SELECT gruppe_id FROM DBX_SECURITY.gruppe_gruppe_zu)
--AND (gruppe_id) NOT IN
--(SELECT gruppe_parent_id FROM DBX_SECURITY.gruppe_gruppe_zu)
--AND (gruppe_id) IN
--(
--SELECT
--gruppe_id
--FROM DBX_DIALOG.d_gruppe
--WHERE loesch_fg = 1
--AND gruppe_id > 0
--)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
DELETE FROM DBX_SECURITY.gruppe
WHERE (gruppe_id) NOT IN
(SELECT gruppe_id FROM DBX_SECURITY.gruppe_user_zu)
AND (gruppe_id) NOT IN
(SELECT gruppe_id FROM DBX_SECURITY.gruppe_zek_zu)
AND (gruppe_id) NOT IN
(SELECT gruppe_id FROM DBX_SECURITY.gruppe_gruppe_zu)
AND (gruppe_id) NOT IN
(SELECT gruppe_parent_id FROM DBX_SECURITY.gruppe_gruppe_zu)
AND (gruppe_id) IN
(
SELECT
gruppe_id
FROM DBX_DIALOG.d_gruppe
WHERE loesch_fg = 1
AND gruppe_id > 0
)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_SECURITY.gruppe
--(
--gruppe_id
--,gruppe_bez
--)
--SELECT
--COALESCE(max_gruppe_id,0) +
--RANK() OVER(PARTITION BY 1 ORDER BY d.gruppe_bez) AS gruppe_bez
--,TRIM(d.gruppe_bez)
--FROM
--(
--SELECT
--gruppe_bez
--FROM DBX_DIALOG.d_gruppe
--
--WHERE gruppe_id = 0 /*neue Gruppen haben die ID 0*/
--AND loesch_fg = 0
--GROUP BY 1 /*falls mehrmals die gleiche Gruppe eingegeben wurde*/
--) d
--
--LEFT OUTER JOIN
--(
--SELECT
--MAX(gruppe_id) AS max_gruppe_id
--FROM DBX_SECURITY.gruppe
--) s
--ON 1=1
--
--WHERE (TRIM(UPPER(gruppe_bez))) NOT IN
--(
--SELECT
--TRIM(UPPER(gruppe_bez))
--FROM DBX_SECURITY.gruppe
--)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
INSERT INTO DBX_SECURITY.gruppe
(
gruppe_id
,gruppe_bez
)
SELECT
COALESCE(max_gruppe_id,0) +
RANK() OVER(PARTITION BY 1 ORDER BY d.gruppe_bez) AS gruppe_bez
,TRIM(d.gruppe_bez)
FROM
(
SELECT
gruppe_bez
FROM DBX_DIALOG.d_gruppe

WHERE gruppe_id = 0 /*neue Gruppen haben die ID 0*/
AND loesch_fg = 0
GROUP BY 1 /*falls mehrmals die gleiche Gruppe eingegeben wurde*/
) d

LEFT OUTER JOIN
(
SELECT
MAX(gruppe_id) AS max_gruppe_id
FROM DBX_SECURITY.gruppe
) s
ON 1=1

WHERE (TRIM(UPPER(gruppe_bez))) NOT IN
(
SELECT
TRIM(UPPER(gruppe_bez))
FROM DBX_SECURITY.gruppe
)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--UPDATE DBX_SECURITY.gruppe
--FROM DBX_DIALOG.d_gruppe d
--
--SET gruppe_bez = d.gruppe_bez
--
--WHERE DBX_SECURITY.gruppe.gruppe_id = d.gruppe_id
--AND d.loesch_fg = 0
--AND d.gruppe_id <> 0
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
UPDATE DBX_SECURITY.gruppe
FROM DBX_DIALOG.d_gruppe d

SET gruppe_bez = d.gruppe_bez

WHERE DBX_SECURITY.gruppe.gruppe_id = d.gruppe_id
AND d.loesch_fg = 0
AND d.gruppe_id <> 0
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_SECURITY.gruppe
--(
--gruppe_id
--,gruppe_bez
--)
--SELECT
--0 AS gruppe_id
--,'Dummy Gruppe' AS gruppe_bez
--WHERE gruppe_id NOT IN
--(
--SELECT
--gruppe_id
--FROM DBX_SECURITY.gruppe
--)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
INSERT INTO DBX_SECURITY.gruppe
(
gruppe_id
,gruppe_bez
)
SELECT
0 AS gruppe_id
,'Dummy Gruppe' AS gruppe_bez
WHERE gruppe_id NOT IN
(
SELECT
gruppe_id
FROM DBX_SECURITY.gruppe
)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_SECURITY.gruppe_zek_zu
--(
--gruppe_id
--,mandant_id
--,zek_id
--,alle_zek_fg
--)
--SELECT
--z.gruppe_id
--,z.mandant_id
--,COALESCE(e.zek_id,a.zek_id)
--,z.alle_zek_fg
--FROM DBX_DIALOG.d_gruppe_zek_zu z
--
--INNER JOIN DBX_SECURITY.gruppe g /*Ref. Integritaet zu Gruppe*/
--ON z.gruppe_id = g.gruppe_id
--
--LEFT OUTER JOIN DBX_DATA.zek e /*Einzelne Zuordnung: alle_zek_fg = 0*/
--ON z.mandant_id = e.mandant_id
--AND z.zek_id = e.zek_id
--AND z.alle_zek_fg = 0
--
--LEFT OUTER JOIN DBX_DATA.zek a /*alle ZEK's dieses Mandanten: alle_zek_fg = 1*/
--ON z.mandant_id = a.mandant_id
--AND z.alle_zek_fg = 1
--
--/*nur neue Zuordnungen*/
--WHERE (z.gruppe_id, z.mandant_id, COALESCE(e.zek_id,a.zek_id)) NOT IN
--(
--SELECT
--gruppe_id
--,mandant_id
--,zek_id
--FROM DBX_SECURITY.gruppe_zek_zu
--)
--
--/*Zuordnungen duerfen nur fuer Blatt Gruppen angelegt werden*/
--AND (z.gruppe_id) NOT IN
--(
--SELECT
--gruppe_parent_id
--FROM DBX_SECURITY.gruppe_gruppe_zu
--)
--
--AND z.loesch_fg = 0
--AND (e.zek_id IS NOT NULL OR a.zek_id IS NOT NULL)
--
--GROUP BY 1,2,3,4 /*Falls mehrfach die gleichen Eintraeg angelegt wurden*/
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
INSERT INTO DBX_SECURITY.gruppe_zek_zu
(
gruppe_id
,mandant_id
,zek_id
,alle_zek_fg
)
SELECT
z.gruppe_id
,z.mandant_id
,COALESCE(e.zek_id,a.zek_id)
,z.alle_zek_fg
FROM DBX_DIALOG.d_gruppe_zek_zu z

INNER JOIN DBX_SECURITY.gruppe g /*Ref. Integritaet zu Gruppe*/
ON z.gruppe_id = g.gruppe_id

LEFT OUTER JOIN DBP_DATA.zek e /*Einzelne Zuordnung: alle_zek_fg = 0*/
ON z.mandant_id = e.mandant_id
AND z.zek_id = e.zek_id
AND z.alle_zek_fg = 0

LEFT OUTER JOIN DBP_DATA.zek a /*alle ZEK's dieses Mandanten: alle_zek_fg = 1*/
ON z.mandant_id = a.mandant_id
AND z.alle_zek_fg = 1

/*nur neue Zuordnungen*/
WHERE (z.gruppe_id, z.mandant_id, COALESCE(e.zek_id,a.zek_id)) NOT IN
(
SELECT
gruppe_id
,mandant_id
,zek_id
FROM DBX_SECURITY.gruppe_zek_zu
)

/*Zuordnungen duerfen nur fuer Blatt Gruppen angelegt werden*/
AND (z.gruppe_id) NOT IN
(
SELECT
gruppe_parent_id
FROM DBX_SECURITY.gruppe_gruppe_zu
)

AND z.loesch_fg = 0
AND (e.zek_id IS NOT NULL OR a.zek_id IS NOT NULL)

GROUP BY 1,2,3,4 /*Falls mehrfach die gleichen Eintraeg angelegt wurden*/
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_SECURITY.gruppe_zek_zu
--(
--gruppe_id
--,mandant_id
--,zek_id
--,alle_zek_fg
--)
--SELECT
--g.gruppe_id
--,g.mandant_id
--,z.zek_id
--,g.alle_zek_fg
--FROM
--(
--SELECT
--mandant_id
--,gruppe_id
--,alle_zek_fg
--FROM DBX_SECURITY.gruppe_zek_zu
--WHERE alle_zek_fg = 1
--GROUP BY 1,2,3
--) g
--
--INNER JOIN DBX_DATA.zek z
--ON g.mandant_id = z.mandant_id
--
--WHERE (g.gruppe_id, g.mandant_id, z.zek_id) NOT IN
--(
--SELECT
--gruppe_id
--,mandant_id
--,zek_id
--FROM DBX_SECURITY.gruppe_zek_zu
--WHERE alle_zek_fg = 1
--)
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
INSERT INTO DBX_SECURITY.gruppe_zek_zu
(
gruppe_id
,mandant_id
,zek_id
,alle_zek_fg
)
SELECT
g.gruppe_id
,g.mandant_id
,z.zek_id
,g.alle_zek_fg
FROM
(
SELECT
mandant_id
,gruppe_id
,alle_zek_fg
FROM DBX_SECURITY.gruppe_zek_zu
WHERE alle_zek_fg = 1
GROUP BY 1,2,3
) g

INNER JOIN DBP_DATA.zek z
ON g.mandant_id = z.mandant_id

WHERE (g.gruppe_id, g.mandant_id, z.zek_id) NOT IN
(
SELECT
gruppe_id
,mandant_id
,zek_id
FROM DBX_SECURITY.gruppe_zek_zu
WHERE alle_zek_fg = 1
)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_SECURITY.gruppe_gruppe_zu
--(
--gruppe_id
--,gruppe_parent_id
--)
--SELECT
--z.gruppe_id
--,z.gruppe_parent_id
--FROM DBX_DIALOG.d_gruppe_gruppe_zu z
--
--INNER JOIN DBX_SECURITY.gruppe g /*Ref. Integritaet Gruppe*/
--ON z.gruppe_id = g.gruppe_id
--
--INNER JOIN DBX_SECURITY.gruppe p /*Ref. Integritaet Gruppe Parent*/
--ON z.gruppe_parent_id = p.gruppe_id
--
--WHERE (z.gruppe_parent_id) NOT IN /*neue Eltern-Gruppe darf keine ZEK Zuordnungen haben*/
--(
--SELECT
--gruppe_id
--FROM DBX_SECURITY.gruppe_zek_zu
--)
--AND (z.gruppe_id, z.gruppe_parent_id) NOT IN /*nur neue Eintraege*/
--(
--SELECT
--gruppe_id
--,gruppe_parent_id
--FROM DBX_SECURITY.gruppe_gruppe_zu
--)
--AND (z.gruppe_id, z.gruppe_parent_id) NOT IN /*Hierarchietiefe maximal 3 Ebenen*/
--(
--SELECT
--CASE WHEN a.herkunft = 'd' THEN a.gruppe_id
--WHEN b.herkunft = 'd' THEN b.gruppe_id
--ELSE c.gruppe_id
--END,
--CASE WHEN a.herkunft = 'd' THEN a.gruppe_parent_id
--WHEN b.herkunft = 'd' THEN b.gruppe_parent_id
--ELSE c.gruppe_parent_id
--END
--FROM DBX_LOAD.gruppe_gruppe_zu_tmp a -- erste und zweite Ebene
--
--INNER JOIN DBX_LOAD.gruppe_gruppe_zu_tmp b -- dritte Ebene
--ON a.gruppe_id = b.gruppe_parent_id
--
--INNER JOIN DBX_LOAD.gruppe_gruppe_zu_tmp c -- vierte Ebene
--ON b.gruppe_id = c.gruppe_parent_id
--)
--AND z.loesch_fg = 0
--
--GROUP BY 1,2 /*Falls mehrfach die gleichen Zuordnungen angelegt wurden*/
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
INSERT INTO DBX_SECURITY.gruppe_gruppe_zu
(
gruppe_id
,gruppe_parent_id
)
SELECT
z.gruppe_id
,z.gruppe_parent_id
FROM DBX_DIALOG.d_gruppe_gruppe_zu z

INNER JOIN DBX_SECURITY.gruppe g /*Ref. Integritaet Gruppe*/
ON z.gruppe_id = g.gruppe_id

INNER JOIN DBX_SECURITY.gruppe p /*Ref. Integritaet Gruppe Parent*/
ON z.gruppe_parent_id = p.gruppe_id

WHERE (z.gruppe_parent_id) NOT IN /*neue Eltern-Gruppe darf keine ZEK Zuordnungen haben*/
(
SELECT
gruppe_id
FROM DBX_SECURITY.gruppe_zek_zu
)
AND (z.gruppe_id, z.gruppe_parent_id) NOT IN /*nur neue Eintraege*/
(
SELECT
gruppe_id
,gruppe_parent_id
FROM DBX_SECURITY.gruppe_gruppe_zu
)
AND (z.gruppe_id, z.gruppe_parent_id) NOT IN /*Hierarchietiefe maximal 3 Ebenen*/
(
SELECT
CASE WHEN a.herkunft = 'd' THEN a.gruppe_id
WHEN b.herkunft = 'd' THEN b.gruppe_id
ELSE c.gruppe_id
END,
CASE WHEN a.herkunft = 'd' THEN a.gruppe_parent_id
WHEN b.herkunft = 'd' THEN b.gruppe_parent_id
ELSE c.gruppe_parent_id
END
FROM DBP_ETL.gruppe_gruppe_zu_tmp a -- erste und zweite Ebene

INNER JOIN DBP_ETL.gruppe_gruppe_zu_tmp b -- dritte Ebene
ON a.gruppe_id = b.gruppe_parent_id

INNER JOIN DBP_ETL.gruppe_gruppe_zu_tmp c -- vierte Ebene
ON b.gruppe_id = c.gruppe_parent_id
)
AND z.loesch_fg = 0

GROUP BY 1,2 /*Falls mehrfach die gleichen Zuordnungen angelegt wurden*/
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_SECURITY.gruppe_user_zu
--(
--gruppe_id
--,user_id
--)
--SELECT
--z.gruppe_id
--,TRIM(z.user_id)
--FROM DBX_DIALOG.d_gruppe_user_zu z
--
--INNER JOIN DBX_SECURITY.gruppe g /*Ref. Integritaet zu Gruppe*/
--ON z.gruppe_id = g.gruppe_id
--
--WHERE z.loesch_fg = 0
--
--GROUP BY 1,2 /*falls mehrfach der gleiche Eintrag angelegt wurde*/
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
INSERT INTO DBX_SECURITY.gruppe_user_zu
(
gruppe_id
,user_id
)
SELECT
z.gruppe_id
,TRIM(z.user_id)
FROM DBX_DIALOG.d_gruppe_user_zu z

INNER JOIN DBX_SECURITY.gruppe g /*Ref. Integritaet zu Gruppe*/
ON z.gruppe_id = g.gruppe_id

WHERE z.loesch_fg = 0

GROUP BY 1,2 /*falls mehrfach der gleiche Eintrag angelegt wurde*/
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBX_SECURITY.user_zek_zu ALL;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
DELETE FROM DBX_SECURITY.user_zek_zu;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_SECURITY.user_zek_zu
--(
--mandant_id
--,zek_id
--,user_id
--)
--SELECT
--mandant_id
--,zek_id
--,user_id
--FROM
--(
---- Zek und User sind direkt einer Gruppe zugeordnet
--SELECT
--z.mandant_id
--,z.zek_id
--,u.user_id
--FROM DBX_SECURITY.gruppe_user_zu u
--
--INNER JOIN DBX_SECURITY.gruppe_zek_zu z
--ON u.gruppe_id = z.gruppe_id
--
--UNION -- Zek und User der ersten Gruppen-Gruppen Zuordnung
--
--SELECT
--z.mandant_id
--,z.zek_id
--,u.user_id
--FROM DBX_SECURITY.gruppe_gruppe_zu g
--
--INNER JOIN DBX_SECURITY.gruppe_user_zu u /*User koennen jeder Ebene zugeordnet sein*/
--ON g.gruppe_id          = u.gruppe_id
--OR g.gruppe_parent_id = u.gruppe_id
--
--INNER JOIN DBX_SECURITY.gruppe_zek_zu z
--ON g.gruppe_id = z.gruppe_id /*zeks koennen nur auf Blattebene zugeordnet sein*/
--
--UNION -- Zek und User der zweiten Gruppen-Gruppen Zuordnung
--
--SELECT
--z.mandant_id
--,z.zek_id
--,u.user_id
--FROM DBX_SECURITY.gruppe_gruppe_zu g
--
--INNER JOIN DBX_SECURITY.gruppe_gruppe_zu gg
--ON g.gruppe_id = gg.gruppe_parent_id
--
--INNER JOIN DBX_SECURITY.gruppe_user_zu u /*User koennen jeder Ebene zugeordnet sein*/
--ON g.gruppe_id          = u.gruppe_id
--OR g.gruppe_parent_id = u.gruppe_id
--OR gg.gruppe_id       = u.gruppe_id
--
--INNER JOIN DBX_SECURITY.gruppe_zek_zu z
--ON gg.gruppe_id = z.gruppe_id /*zeks koennen nur auf Blattebene zugeordnet sein*/
--) a
--GROUP BY 1,2,3
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
INSERT INTO DBX_SECURITY.user_zek_zu
(
mandant_id
,zek_id
,user_id
)
SELECT
mandant_id
,zek_id
,user_id
FROM
(
-- Zek und User sind direkt einer Gruppe zugeordnet
SELECT
z.mandant_id
,z.zek_id
,u.user_id
FROM DBX_SECURITY.gruppe_user_zu u

INNER JOIN DBX_SECURITY.gruppe_zek_zu z
ON u.gruppe_id = z.gruppe_id

UNION -- Zek und User der ersten Gruppen-Gruppen Zuordnung

SELECT
z.mandant_id
,z.zek_id
,u.user_id
FROM DBX_SECURITY.gruppe_gruppe_zu g

INNER JOIN DBX_SECURITY.gruppe_user_zu u /*User koennen jeder Ebene zugeordnet sein*/
ON g.gruppe_id          = u.gruppe_id
OR g.gruppe_parent_id = u.gruppe_id

INNER JOIN DBX_SECURITY.gruppe_zek_zu z
ON g.gruppe_id = z.gruppe_id /*zeks koennen nur auf Blattebene zugeordnet sein*/

UNION -- Zek und User der zweiten Gruppen-Gruppen Zuordnung

SELECT
z.mandant_id
,z.zek_id
,u.user_id
FROM DBX_SECURITY.gruppe_gruppe_zu g

INNER JOIN DBX_SECURITY.gruppe_gruppe_zu gg
ON g.gruppe_id = gg.gruppe_parent_id

INNER JOIN DBX_SECURITY.gruppe_user_zu u /*User koennen jeder Ebene zugeordnet sein*/
ON g.gruppe_id          = u.gruppe_id
OR g.gruppe_parent_id = u.gruppe_id
OR gg.gruppe_id       = u.gruppe_id

INNER JOIN DBX_SECURITY.gruppe_zek_zu z
ON gg.gruppe_id = z.gruppe_id /*zeks koennen nur auf Blattebene zugeordnet sein*/
) a
GROUP BY 1,2,3
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBX_DIALOG.d_gruppe;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
DELETE FROM DBX_DIALOG.d_gruppe;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBX_DIALOG.d_gruppe_gruppe_zu;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
DELETE FROM DBX_DIALOG.d_gruppe_gruppe_zu;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBX_DIALOG.d_gruppe_zek_zu;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
DELETE FROM DBX_DIALOG.d_gruppe_zek_zu;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBX_DIALOG.d_gruppe_user_zu;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
DELETE FROM DBX_DIALOG.d_gruppe_user_zu;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBX_MSI_DATA.art_zek_zu
--WHERE mandant_id <> 1
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
DELETE FROM DBX_MSI_DATA.art_zek_zu
WHERE mandant_id <> 1
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_MSI_DATA.art_zek_zu
--(
--mandant_id
--,art_id
--,zek_id
--)
---- Artikel Zek Zuordnungen auf Basis art
--SELECT
--mandant_id
--,art_id
--,zek_id
--FROM DBX_DATA.art
--
--WHERE dat_bis = 80991231
--AND mandant_id <> 1
--
--UNION
--
---- Berechtigungsebene WGI (wenn mindestens ein Artikel
---- durch User-Zek Zuordnung in der WGI ist, darf die gesamte
---- WGI angesehen werden.
--SELECT
--aw2.mandant_id
--,aw2.art_id
--,aw.zek_id
--FROM
--(
--SELECT
--a.mandant_id
--,aw.wg_id
--,aw.wug_id
--,a.zek_id
--FROM DBX_DATA.art a
--
---- WGI fuer Artikel ermitteln
--INNER JOIN DBX_DATA.art_wg_zu_per aw
--ON a.mandant_id        = aw.mandant_id
--AND a.art_id         = aw.art_id
--AND aw.dat_bis       = 80991231
--AND aw.arthiertyp_id = 2
--
--WHERE a.mandant_id <> 1
--
--GROUP BY
--a.mandant_id
--,aw.wg_id
--,aw.wug_id
--,a.zek_id
--) aw
--
--INNER JOIN DBX_DATA.art_wg_zu_per aw2
--ON aw2.mandant_id        = aw.mandant_id
--AND aw2.wg_id          = aw.wg_id
--AND aw2.wug_id         = aw.wug_id
--AND aw2.arthiertyp_id  = 2
--AND aw2.dat_bis        = 80991231
--AND aw2.mandant_id    <> 1
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
INSERT INTO DBX_MSI_DATA.art_zek_zu
(
mandant_id
,art_id
,zek_id
)
-- Artikel Zek Zuordnungen auf Basis art
SELECT
mandant_id
,art_id
,zek_id
FROM DBP_DATA.art

WHERE dat_bis = to_date('9999-12-31','YYYY-MM-DD')
AND mandant_id <> 1

UNION

-- Berechtigungsebene WGI (wenn mindestens ein Artikel
-- durch User-Zek Zuordnung in der WGI ist, darf die gesamte
-- WGI angesehen werden.
SELECT
aw2.mandant_id
,aw2.art_id
,aw.zek_id
FROM
(
SELECT
a.mandant_id
,aw.wg_id
,aw.wug_id
,a.zek_id
FROM DBP_DATA.art a

-- WGI fuer Artikel ermitteln
INNER JOIN DBP_DATA.art_wg_zu_per aw
ON a.mandant_id        = aw.mandant_id
AND a.art_id         = aw.art_id
AND aw.dat_bis       = to_date('9999-12-31','YYYY-MM-DD')
AND aw.arthiertyp_id = 2

WHERE a.mandant_id <> 1

GROUP BY
a.mandant_id
,aw.wg_id
,aw.wug_id
,a.zek_id
) aw

INNER JOIN DBP_DATA.art_wg_zu_per aw2
ON aw2.mandant_id        = aw.mandant_id
AND aw2.wg_id          = aw.wg_id
AND aw2.wug_id         = aw.wug_id
AND aw2.arthiertyp_id  = 2
AND aw2.dat_bis        = to_date('9999-12-31','YYYY-MM-DD')
AND aw2.mandant_id    <> 1
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBX_MSI_DATA.wg_zek_zu;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
DELETE FROM DBX_MSI_DATA.wg_zek_zu;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO DBX_MSI_DATA.wg_zek_zu
--(
--mandant_id
--,wg_id
--,arthiertyp_id
--,zek_id
--)
--SELECT
--aw.mandant_id
--,aw.wg_id
--,aw.arthiertyp_id
--,a.zek_id
--FROM DBX_DATA.art a
--
--INNER JOIN DBX_DATA.art_wg_zu_per aw
--ON aw.mandant_id       = a.mandant_id
--AND aw.art_id        = a.art_id
--AND aw.dat_bis       = 80991231
--AND aw.arthiertyp_id = 2
---- AND aw.mandant_id   <> 1
--
--GROUP BY
--aw.mandant_id
--,aw.wg_id
--,aw.arthiertyp_id
--,a.zek_id
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
INSERT INTO DBX_MSI_DATA.wg_zek_zu
(
mandant_id
,wg_id
,arthiertyp_id
,zek_id
)
SELECT
aw.mandant_id
,aw.wg_id
,aw.arthiertyp_id
,a.zek_id
FROM DBP_DATA.art a

INNER JOIN DBP_DATA.art_wg_zu_per aw
ON aw.mandant_id       = a.mandant_id
AND aw.art_id        = a.art_id
AND aw.dat_bis       = to_date('9999-12-31','YYYY-MM-DD')
AND aw.arthiertyp_id = 2
-- AND aw.mandant_id   <> 1

GROUP BY
aw.mandant_id
,aw.wg_id
,aw.arthiertyp_id
,a.zek_id
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE DBX_LOAD.gruppe_gruppe_zu_tmp;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
DROP TABLE IF EXISTS DBP_ETL.gruppe_gruppe_zu_tmp;

