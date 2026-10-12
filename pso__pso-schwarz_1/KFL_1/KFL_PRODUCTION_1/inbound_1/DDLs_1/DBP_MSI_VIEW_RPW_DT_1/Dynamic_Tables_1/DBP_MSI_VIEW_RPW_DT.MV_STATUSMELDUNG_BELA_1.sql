create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_STATUSMELDUNG_BELA_1(
	ECM_VORGANG,
	MANDANT_ID,
	SYSTEM_ID,
	BELEGKLASSE_ID,
	STATUSCODE_ID,
	GP_ID,
	ZEITSTEMPEL,
	DAT,
	LAUFZEIT_TAGE,
	ANZAHL_EK,
	ANZAHL_MAHNUNG
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
-- 26.11.2013 twie: spezielle View für Bericht 2.12 Vorgangslaufzeiterhebung Bela-Frühwarnsystem
-- Die View gibt pro ECM Vorgang eine_1 Zeile aus. Dazu muss der Vorgang den Status_1 2001 eröffnet haben (nach diesem kann im Bericht mit dat eingeschränkt werden)
-- Er muss bereits geschlossen sein (Inner Join auf Status_1 2013) und zur Belegklasse BELA gehören.
-- Außerdem ist er nur relevant, wenn er im Einkauf war, dazu muss er Status_1 2005 und danach 2004 gehabt haben.
-- Dies kann auch mehrmals passieren und wird mittels anzahl_ek gezählt. Und es wird die Laufzeit im EK gemessen.
-- Dazu werden alle Zeitspannen addiert, die zwischen Status_1 2005 und 2004 liegen.
-- Optional werden die Anzahl der Mahnungen pro Vorgang gezählt (Outer Join auf Status_1 2012)

SELECT
    v01.ecm_vorgang
    , v01.mandant_id
    ,7 AS system_id
    ,v01.belegklasse_id
    ,v01.statuscode_id
    -- gruppieren, falls es pro Vorgang mehr als einmal den Status_1 2001 geben sollte
    ,MAX(v01.gp_id) AS gp_id
    ,MIN(v01.zeitstempel) AS zeitstempel
    ,MIN(v01.dat) AS dat -- entspricht Tag_1 aus zeitstempel
    ,MIN(v02.laufzeit_min / 1440) AS laufzeit_tage
    ,MIN(v02.anzahl_ek) AS anzahl_ek
    ,MIN(COALESCE(v03.anzahl_mahnung,0)) AS anzahl_mahnung
    -- Status_1 2001 zum selektieren Zeitpunkt
FROM dbp_view.v_statusmeldung_1 v01
-- Laufzeiten im Einkauf (von Status_1 2005 auf 2004) ermitteln
-- Das ist die Zeitspanne zwischen Zeitstempel von Status_1 2005 und 2004
INNER JOIN (
SELECT
-- ermittelt pro relevantem ECM Vorgang die Laufzeit und wie oft er im Einkauf war
    ecm_vorgang
    ,SUM(CAST(CASE WHEN statuscode_id = 2005 AND statuscode_folge_id = 2004 THEN dauer_in_min ELSE 0 END AS NUMBER(38,5))) AS laufzeit_min
    ,SUM(CASE WHEN statuscode_id = 2005 AND statuscode_folge_id = 2004 THEN 1 ELSE 0 END) AS anzahl_ek
FROM
(
    SELECT
    ecm_vorgang
    ,zeitstempel
    ,statuscode_id
    ,COALESCE(
        -- den Zeitstempel vom Folgesatz (nur 2004 oder 2005) ermitteln
        -- falls zeitstempel identisch, nach lfd_nr sortieren
        MAX(zeitstempel) OVER (PARTITION BY ecm_vorgang ORDER BY zeitstempel ASC, statusmeldung_ecm_lfd_nr ASC ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)
        ,zeitstempel --wenn kein Folgesatz mehr da
    ) AS zeitstempel_folge
    ,COALESCE(
        -- den Statuscode vom Folgesatz (nur 2004 oder 2005) ermitteln
        MAX(statuscode_id) OVER (PARTITION BY ecm_vorgang ORDER BY zeitstempel ASC, statusmeldung_ecm_lfd_nr ASC ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)
        ,statuscode_id  --wenn kein Folgesatz mehr da
    ) AS statuscode_folge_id
    -- Abstand zwischen Zeitstempel und Zeitstempel des Folgesatzes in Minuten
    ,CASE WHEN zeitstempel IS NOT NULL THEN TIMEDIFF('MINUTE', zeitstempel, zeitstempel_folge)
        --(EXTRACT (DAY FROM(zeitstempel_folge - zeitstempel DAY(4) TO SECOND)) *1440) +
        --(EXTRACT (HOUR FROM(zeitstempel_folge - zeitstempel DAY(4) TO SECOND)) *60) +
        --(EXTRACT (MINUTE FROM(zeitstempel_folge - zeitstempel DAY(4) TO SECOND)))
    ELSE NULL END AS dauer_in_min
FROM dbp_view.v_statusmeldung_1
WHERE mandant_id = 1
AND belegklasse_id = 'BELA'
-- nur Übergänge von 2005 auf 2004 relevant
AND statuscode_id IN (2004, 2005)
) subsel
-- nur Vorgänge, die mind. 1x im EK waren (von Status_1 2005 zu 2004 gewechselt)
GROUP BY 1
HAVING anzahl_ek > 0
) v02
ON v01.ecm_vorgang = v02.ecm_vorgang
-- Anzahl Mahnungen, falls vorhanden (Status_1 2012)
LEFT OUTER JOIN (
SELECT
ecm_vorgang
,COUNT(statuscode_id) AS anzahl_mahnung
FROM dbp_view.v_statusmeldung_1
WHERE mandant_id = 1
AND belegklasse_id = 'BELA'
AND statuscode_id = 2012
GROUP BY 1
) v03
ON v01.ecm_vorgang = v03.ecm_vorgang
-- Vorgang muss schon geschlossen sein (Status_1 2013)
INNER JOIN ( --pro Vorgang eine_1 Zeile, auch wenn mehrfach 2013 im Vorgang
SELECT
ecm_vorgang
FROM dbp_view.v_statusmeldung_1
WHERE mandant_id = 1
AND belegklasse_id = 'BELA'
AND statuscode_id = 2013
GROUP BY 1
) v04
ON v01.ecm_vorgang = v04.ecm_vorgang
WHERE v01.mandant_id = 1
-- nur BELA Belege
AND v01.belegklasse_id = 'BELA'
-- Beleg muss zum selektierten Datum den Status_1 2001  haben
AND v01.statuscode_id = 2001
-- Falls es pro Vorgang mehrmals Status_1 2001 geben sollte
-- nur ein Datensatz pro Vorgang ausgeben, sonst Datenvervielfältigung
GROUP BY 1,2,3,4,5
;
