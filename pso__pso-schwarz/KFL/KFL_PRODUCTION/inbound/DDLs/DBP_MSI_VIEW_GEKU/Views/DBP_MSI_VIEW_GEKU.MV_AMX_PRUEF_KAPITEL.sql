CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_AMX_PRUEF_KAPITEL(
	PRUEF_KAPITEL_ID,
	AMX_SYSTEM_ID,
	PRUEFUNG_ID,
	PRUEF_KAPITEL_BEZ,
	KAPITEL_ERGEBNIS_WERT
) AS
-- 20160322 KKaiser, neu für AP0002158 Audimex,hauptbereich_id
-- 20160324 twie: teilbereich_id und hauptbereich_id über amx_frage_katalog ermitteln, nicht über Prüfkapitel
-- 20160506 twie: zeitlich begrenzt, ab wann Daten ausgewertet werden, pro Land
-- 20170803 twie: SPEC0024880 audimex Datenmodell von VIS in KMR umziehen
-- 20190109 twie: NSR0506061 Filter zustand_id erweitert um 100025
-- 20191111 twie: NSR1071081 Erweiterung Filterung um Moldau
-- 20200629 twie: SPEC0080405 Erweiterung aller audimex Tabellen um amx_system_id für den PK
-- 20230316 twie: SPEC0190886 für DE Daten gibt es eigenständige Tabellen, die jeweils per Union ergänzt werden (enthalten nur Daten für amx_system_id = 1)

SELECT
v01.pruef_kapitel_id,
v01.amx_system_id,
v01.pruefung_id, 
v01.pruef_kapitel_bez,
v01.kapitel_ergebnis_wert

FROM
(
SELECT 
pruef_kapitel_id,
amx_system_id,
pruefung_id, 
pruef_kapitel_bez,
kapitel_ergebnis_wert

FROM dbp_view.v_amx_pruef_kapitel

--separate Tabelle mit DE Daten:
UNION

SELECT 
pruef_kapitel_id,
1 AS amx_system_id, -- DE-Prüfungen werden ab 2023 ausschließlich im AMX-Core erfasst
pruefung_id, 
pruef_kapitel_bez,
kapitel_ergebnis_wert

FROM dbp_view.v_amx_de_pruef_kapitel
)v01

INNER JOIN 
(SELECT
 pruefung_id
,amx_system_id
,zustand_id
,dat_ende
,mandant_id

FROM dbp_view.v_amx_pruefung 

--separate Tabelle mit DE Daten:
UNION

SELECT 
 pruefung_id
,1 AS amx_system_id -- DE-Prüfungen werden ab 2023 ausschließlich im AMX-Core erfasst
,zustand_id
,dat_ende
,mandant_id

FROM dbp_view.v_amx_de_pruefung) v02
ON v01.pruefung_id = v02.pruefung_id
AND v01.amx_system_id = v02.amx_system_id

LEFT OUTER JOIN
( --Ermittlung aller Prüfungen die mindestens einen Prüfprozess zum Thema Arbeitsschutz AS oder Gesundheitsschutz GS zugeordnet haben
SELECT DISTINCT
pruefung_id -- Prüfung kann mehreren Prozessen zugeordnet sein
,amx_system_id
,1 AS asgs_flag --Flag, dass Prüfung zu AS oder GS gehört 
FROM dbp_view.v_amx_b_process_pruefung_zu

WHERE ((amx_system_id = 2 AND business_process_id IN (102803,117032,102805))
OR (amx_system_id = 1 AND business_process_id IN (544687,544691,544689))) --AS und GS

UNION -- Tabelle für DE

SELECT DISTINCT
pruefung_id -- Prüfung kann mehreren Prozessen zugeordnet sein
,1 AS amx_system_id -- DE-Prüfungen werden ab 2023 ausschließlich im AMX-Core erfasst
,1 AS asgs_flag --Flag, dass Prüfung zu AS oder GS gehört 
FROM dbp_view.v_amx_de_b_process_pruefung_zu

WHERE (business_process_id IN (544687,544691,544689)) --AS und GS
) v03
ON v02.pruefung_id = v03.pruefung_id
AND v02.amx_system_id = v03.amx_system_id

WHERE  ((v02.amx_system_id = 2 AND v02.zustand_id IN (100003, 100004, 100005, 1001, 100025))
OR (v02.amx_system_id = 1 AND v02.zustand_id IN (100005,1001,100041)))--nur diese relevant für audimex
AND  -- je Land Daten ab bestimmten Datum auswerten (Einführung audimex) bzw. bei DE noch unterschieden nach Prozessen. Daten zuvor sind nicht komplett

      (
      (v02.mandant_id = 1 AND v03.asgs_flag = 1 AND v02.dat_ende >= CAST('2015-03-01' AS DATE)) OR (v02.mandant_id = 1 AND v03.asgs_flag IS NULL AND v02.dat_ende >= CAST('2015-06-01' AS DATE)) OR
      (v02.mandant_id = 2 AND v02.dat_ende >= CAST('2015-03-01' AS DATE)) OR (v02.mandant_id = 3 AND v02.dat_ende >= CAST('2015-06-22' AS DATE)) OR (v02.mandant_id = 4 AND v02.dat_ende >= CAST('2019-10-31' AS DATE)) OR
      (v02.mandant_id = 5 AND v02.dat_ende >= CAST('2015-07-16' AS DATE)) OR (v02.mandant_id = 6 AND v02.dat_ende >= CAST('2015-10-29' AS DATE)) OR (v02.mandant_id = 7 AND v02.dat_ende >= CAST('2015-12-01' AS DATE)) OR
      (v02.mandant_id = 8 AND v02.dat_ende >= CAST('2015-12-01' AS DATE))
      )
;