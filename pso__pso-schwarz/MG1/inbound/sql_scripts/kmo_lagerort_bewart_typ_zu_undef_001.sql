--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_DATA}.lagerort_bewart_typ_zu
--SELECT t01.mandant_id
--, t01.lagerort_id
--, t01.lagernummer_id
--, t01.wup_id
--, t01.nb_id
--, t02.grund_id
--, t01.lager_bewart_id
--, t01.lager_bewart_typ_id
--, t01.system_id
--FROM (
--SELECT t1.mandant_id, t1.lagerort_id, t1.lagernummer_id, t1.wup_id, t1.nb_id, t1.lager_bewart_id, t1.lager_bewart_typ_id, t1.system_id
--FROM ${DWH_COMMON_DBX_DATA}.lagerort_bewart_typ_zu t1
--WHERE t1.nb_id IN (99,-111)
--GROUP BY t1.mandant_id, t1.lagerort_id, t1.lagernummer_id, t1.wup_id, t1.nb_id, t1.lager_bewart_id, t1.lager_bewart_typ_id, t1.system_id
--) t01
--JOIN ${DWH_COMMON_DBX_DATA}.l_lager_bewgrund t02
--ON t01.mandant_id = t02.mandant_id
--AND t01.lager_bewart_id = t02.lager_bewart_id
---- AND t01.grund_id <> t02.grund_id
--LEFT OUTER JOIN ${DWH_COMMON_DBX_DATA}.lagerort_bewart_typ_zu t03
--ON t01.mandant_id = t03.mandant_id
--AND t01.lagerort_id = t03.lagerort_id
--AND COALESCE(t01.lagernummer_id, '') = COALESCE(t03.lagernummer_id, '')
--AND t01.wup_id = t03.wup_id
--AND t01.nb_id = t03.nb_id
--AND t01.lager_bewart_id = t03.lager_bewart_id
--AND t02.grund_id = t03.grund_id
--JOIN
--( -- Finde hier die Saetze, deren bewart eindeutig einem Verursacher zuzuordnen ist.
--SELECT
--wup_id
--,nb_id
--,lagerort_id
--,mandant_id
--,lagernummer_id
--,lager_bewart_id
--FROM ( -- Reduziere um den Bewegungsgrund
--SELECT
--mandant_id
--,lagerort_id
--,lagernummer_id
--,wup_id
--,nb_id
--,lager_bewart_id
--,lager_bewart_typ_id
--FROM ${DWH_COMMON_DBX_DATA}.lagerort_bewart_typ_zu t01
--GROUP BY
--mandant_id
--,lagerort_id
--,lagernummer_id
--,wup_id
--,nb_id
--,lager_bewart_id
--,lager_bewart_typ_id
--) x
--GROUP BY
--mandant_id
--,lagerort_id
--,lagernummer_id
--,wup_id
--,nb_id
--,lager_bewart_id
--HAVING COUNT(*) = 1
--) t04
--ON t01.mandant_id = t04.mandant_id
--AND t01.lagerort_id = t04.lagerort_id
--AND COALESCE(t01.lagernummer_id, '') = COALESCE(t04.lagernummer_id, '')
--AND t01.wup_id = t04.wup_id
--AND t01.nb_id = t04.nb_id
--AND t01.lager_bewart_id = t04.lager_bewart_id
--WHERE t03.mandant_id is null
--GROUP BY 1,2,3,4,5,6,7,8,9;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
INSERT INTO DBP_DATA.lagerort_bewart_typ_zu
SELECT t01.mandant_id
, t01.lagerort_id
, t01.lagernummer_id
, t01.wup_id
, t01.nb_id
, t02.grund_id
, t01.lager_bewart_id
, t01.lager_bewart_typ_id
, t01.system_id
FROM (
SELECT t1.mandant_id, t1.lagerort_id, t1.lagernummer_id, t1.wup_id, t1.nb_id, t1.lager_bewart_id, t1.lager_bewart_typ_id, t1.system_id
FROM DBP_DATA.lagerort_bewart_typ_zu t1
WHERE t1.nb_id IN (99,-111)
GROUP BY t1.mandant_id, t1.lagerort_id, t1.lagernummer_id, t1.wup_id, t1.nb_id, t1.lager_bewart_id, t1.lager_bewart_typ_id, t1.system_id
) t01
JOIN DBP_DATA.l_lager_bewgrund t02
ON t01.mandant_id = t02.mandant_id
AND t01.lager_bewart_id = t02.lager_bewart_id
-- AND t01.grund_id <> t02.grund_id
LEFT OUTER JOIN DBP_DATA.lagerort_bewart_typ_zu t03
ON t01.mandant_id = t03.mandant_id
AND t01.lagerort_id = t03.lagerort_id
AND COALESCE(t01.lagernummer_id, '') = COALESCE(t03.lagernummer_id, '')
AND t01.wup_id = t03.wup_id
AND t01.nb_id = t03.nb_id
AND t01.lager_bewart_id = t03.lager_bewart_id
AND t02.grund_id = t03.grund_id
JOIN
( -- Finde hier die Saetze, deren bewart eindeutig einem Verursacher zuzuordnen ist.
SELECT
wup_id
,nb_id
,lagerort_id
,mandant_id
,lagernummer_id
,lager_bewart_id
FROM ( -- Reduziere um den Bewegungsgrund
SELECT
mandant_id
,lagerort_id
,lagernummer_id
,wup_id
,nb_id
,lager_bewart_id
,lager_bewart_typ_id
FROM DBP_DATA.lagerort_bewart_typ_zu t01
GROUP BY
mandant_id
,lagerort_id
,lagernummer_id
,wup_id
,nb_id
,lager_bewart_id
,lager_bewart_typ_id
) x
GROUP BY
mandant_id
,lagerort_id
,lagernummer_id
,wup_id
,nb_id
,lager_bewart_id
HAVING COUNT(*) = 1
) t04
ON t01.mandant_id = t04.mandant_id
AND t01.lagerort_id = t04.lagerort_id
AND COALESCE(t01.lagernummer_id, '') = COALESCE(t04.lagernummer_id, '')
AND t01.wup_id = t04.wup_id
AND t01.nb_id = t04.nb_id
AND t01.lager_bewart_id = t04.lager_bewart_id
WHERE t03.mandant_id is null
GROUP BY 1,2,3,4,5,6,7,8,9;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_DATA}.lagerort_bewart_typ_zu (
--mandant_id
--, lagerort_id
--, lagernummer_id
--, wup_id
--, nb_id
--, grund_id
--, lager_bewart_id
--, lager_bewart_typ_id
--, system_id
--)
--SELECT
--t02.mandant_id
--, t02.lagerort_id
--, COALESCE(t02.lagernummer_id, '')
--, t02.wup_id
--, t02.nb_id
--, t04.grund_id
--, t03.lager_bewart_id
--, -1 lager_bewart_typ_id
--, t03.system_id
--FROM ${DWH_COMMON_DBX_DATA}.l_lagerort t02
--JOIN ${DWH_COMMON_DBX_DATA}.l_lager_bewart t03
--ON t02.mandant_id = t03.mandant_id
--JOIN ${DWH_COMMON_DBX_DATA}.l_lager_bewgrund t04
--ON t03.mandant_id = t04.mandant_id
--AND t03.lager_bewart_id = t04.lager_bewart_id
--LEFT JOIN ${DWH_COMMON_DBX_DATA}.lagerort_bewart_typ_zu t05
--ON t02.mandant_id = t05.mandant_id
---- AND COALESCE(t02.lagernummer_id, '') = COALESCE(t05.lagernummer_id, '')
--AND t02.wup_id = t05.wup_id
--AND t02.nb_id = t05.nb_id
--AND t02.lagerort_id = t05.lagerort_id
--AND t03.lager_bewart_id = t05.lager_bewart_id
--AND t04.grund_id = t05.grund_id
--WHERE t05.mandant_id IS NULL
--AND t02.nb_id IN (99,-111);
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
INSERT INTO DBP_DATA.lagerort_bewart_typ_zu (
mandant_id
, lagerort_id
, lagernummer_id
, wup_id
, nb_id
, grund_id
, lager_bewart_id
, lager_bewart_typ_id
, system_id
)
SELECT
t02.mandant_id
, t02.lagerort_id
, COALESCE(t02.lagernummer_id, '')
, t02.wup_id
, t02.nb_id
, t04.grund_id
, t03.lager_bewart_id
, -1 lager_bewart_typ_id
, t03.system_id
FROM DBP_DATA.l_lagerort t02
JOIN DBP_DATA.l_lager_bewart t03
ON t02.mandant_id = t03.mandant_id
JOIN DBP_DATA.l_lager_bewgrund t04
ON t03.mandant_id = t04.mandant_id
AND t03.lager_bewart_id = t04.lager_bewart_id
LEFT JOIN DBP_DATA.lagerort_bewart_typ_zu t05
ON t02.mandant_id = t05.mandant_id
-- AND COALESCE(t02.lagernummer_id, '') = COALESCE(t05.lagernummer_id, '')
AND t02.wup_id = t05.wup_id
AND t02.nb_id = t05.nb_id
AND t02.lagerort_id = t05.lagerort_id
AND t03.lager_bewart_id = t05.lager_bewart_id
AND t04.grund_id = t05.grund_id
WHERE t05.mandant_id IS NULL
AND t02.nb_id IN (99,-111);

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--UPDATE lbt
--FROM ${DWH_COMMON_DBX_DATA}.lagerort_bewart_typ_zu lbt,
--${DWH_COMMON_DBX_DATA}.l_lagerort lo
--SET  lagernummer_id = lo.lagernummer_id
--WHERE lbt.mandant_id = lo.mandant_id AND
--lbt.lagerort_id = lo.lagerort_id AND
--lbt.wup_id      = lo.wup_id AND
--lbt.lagernummer_id <> lo.lagernummer_id AND
--lo.lagernummer_id  IS NOT NULL
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
UPDATE lbt
FROM DBP_DATA.lagerort_bewart_typ_zu lbt,
DBP_DATA.l_lagerort lo
SET  lagernummer_id = lo.lagernummer_id
WHERE lbt.mandant_id = lo.mandant_id AND
lbt.lagerort_id = lo.lagerort_id AND
lbt.wup_id      = lo.wup_id AND
lbt.lagernummer_id <> lo.lagernummer_id AND
lo.lagernummer_id  IS NOT NULL
;

