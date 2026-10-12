CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_amx_feststellung
(
feststellung_id
,amx_system_id
,amx_frage_id
,feststellung_bez
)
AS
-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20160324 twie: hängt nur an Frage, keine Kreisbeziehungen über Prüfung oder Prüfkapitel
-- 20160506 twie: zeitlich begrenzt, ab wann Daten ausgewertet werden, pro Land
-- 20160923 twie: SPEC0013335 Viewfilterung auf antwort_wert 0 (ohne) und 4 (mit Feststellung) entfernt, alle Fragen sollen auswertbar sein. Betrifft nur flex. Bericht (Quote und Zufa haben entspr. Metrikfilter)
-- 20170803 twie: SPEC0024880 audimex Datenmodell von VIS in KMR umziehen
-- 20190109 twie: NSR0506061 Filter zustand_id erweitert um 100025
-- 20191111 twie: NSR1071081 Erweiterung Filterung um Moldau
-- 20200629 twie: SPEC0080405 Erweiterung aller audimex Tabellen um amx_system_id für den PK
-- 20230316 twie: SPEC0190886 Anbindung eigene Tabelle für DE Daten, es gibt aber keine für Festellungen, deshalb kann die Entität Feststellung nicht mit den DE Fragen verwendet werden

SELECT
v01.feststellung_id,
v01.amx_system_id,
v01.amx_frage_id,
v01.feststellung_bez

FROM dbp_view.v_amx_feststellung v01

INNER JOIN dbp_view.v_amx_frage v02
ON v01.amx_frage_id = v02.amx_frage_id
AND v01.amx_system_id = v02.amx_system_id

INNER JOIN dbp_view.v_amx_pruef_kapitel v03
ON v02.pruef_kapitel_id = v03.pruef_kapitel_id
AND v02.amx_system_id = v03.amx_system_id

INNER JOIN dbp_view.v_amx_pruefung v04
ON v03.pruefung_id = v04.pruefung_id
AND v03.amx_system_id = v04.amx_system_id

LEFT OUTER JOIN
( --Ermittlung aller Prüfungen die mindestens einen Prüfprozess zum Thema Arbeitsschutz AS oder Gesundheitsschutz GS zugeordnet haben
SELECT DISTINCT
pruefung_id -- Prüfung kann mehreren Prozessen zugeordnet sein
,amx_system_id,
1 AS asgs_flag --Flag, dass Prüfung zu AS oder GS gehört

FROM dbp_view.v_amx_b_process_pruefung_zu
WHERE ((amx_system_id = 2 AND business_process_id IN (102803,117032,102805))
OR (amx_system_id = 1 AND business_process_id IN (544687,544691,544689))) --AS und GS
) v05
ON v04.pruefung_id = v05.pruefung_id
AND v04.amx_system_id = v05.amx_system_id

WHERE  ((v04.amx_system_id = 2 AND v04.zustand_id IN (100003, 100004, 100005, 1001, 100025))
OR (v04.amx_system_id = 1 AND v04.zustand_id IN (100005,1001,100041)))--nur diese relevant für audimex
AND  -- je Land Daten ab bestimmten Datum auswerten (Einführung audimex) bzw. bei DE noch unterschieden nach Prozessen. Daten zuvor sind nicht komplett

      (
      (v04.mandant_id = 1 AND v05.asgs_flag = 1 AND v04.dat_ende >= CAST('2015-03-01' AS DATE)) OR (v04.mandant_id = 1 AND v05.asgs_flag IS NULL AND v04.dat_ende >= CAST('2015-06-01' AS DATE)) OR
      (v04.mandant_id = 2 AND v04.dat_ende >= CAST('2015-03-01' AS DATE)) OR (v04.mandant_id = 3 AND v04.dat_ende >= CAST('2015-06-22' AS DATE)) OR (v04.mandant_id = 4 AND v04.dat_ende >= CAST('2019-10-31' AS DATE)) OR
      (v04.mandant_id = 5 AND v04.dat_ende >= CAST('2015-07-16' AS DATE)) OR (v04.mandant_id = 6 AND v04.dat_ende >= CAST('2015-10-29' AS DATE)) OR (v04.mandant_id = 7 AND v04.dat_ende >= CAST('2015-12-01' AS DATE)) OR
      (v04.mandant_id = 8 AND v04.dat_ende >= CAST('2015-12-01' AS DATE))
      )
;