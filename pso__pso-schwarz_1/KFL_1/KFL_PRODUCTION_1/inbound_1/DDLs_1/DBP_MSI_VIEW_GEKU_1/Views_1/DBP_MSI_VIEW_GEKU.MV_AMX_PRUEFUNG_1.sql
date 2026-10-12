CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_AMX_PRUEFUNG_1
(
	PRUEFUNG_ID,
	AMX_SYSTEM_ID,
	PRUEFUNG_NR,
	ZUSTAND_ID,
	PRUEFUNG_BEZ,
	DAT_START,
	DAT_ENDE,
	REVISOR_ID,
	PRUEFUNG_TYP_ID,
	PRUEFUNG_KLASSE_ID,
	PRUEFUNG_ERGEBNIS_WERT,
	PRUEFUNG_ERGEBNIS_WERT_ONEAMX,
	BUSINESS_UNIT_ID,
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	ZEITSPANNE,
	SEC_KZ
) AS

-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20160324 twie: Filterung auf zustand_id gilt global für audimex
-- 20160506 twie: zeitlich begrenzt, ab wann Daten ausgewertet werden, pro Land_1
-- 20160520 twie: wup_id -1 zu 0, weil so in wup_1 Tabelle
-- 20170803 twie: SPEC0024880 audimex Datenmodell von VIS in KMR umziehen
-- 20170803 twie: SPEC0024880 nb_id ermitteln weil Schlüsselfeld in Filiale
-- 20170821 twie: SPEC0025359 neues Security Kennzeichen für Sicherheitsfilter
-- 20181213 nfis: INC0670478 - Erweiterung Liste Zustand-ID
-- 20191111 twie: NSR1071081 Erweiterung Filterung um Moldau
-- 20200629 twie: SPEC0080405 Erweiterung aller audimex Tabellen um amx_system_id für den PK
-- 20200630 twie: SPEC0080405 pruefung_ergebnis_wert je amx_system_id aufteilen, durch Dimensionierung in MSI sonst nicht mehr möglich
-- 20210304 twie: SPEC0097017 neue Spalte zeitspanne hinzu
-- 20210831 twie: SPEC0123505 zeitspanne keine -1 anzeigen
-- 20221012 twie: SPEC0167837 sek_kz von 31 auf 6 geändert
-- 20230316 twie: SPEC0190886 für DE Daten gibt es eigenständige Tabellen, die jeweils per Union ergänzt werden (enthalten nur Daten für amx_system_id = 1)
-- 20240814 twie: SPEC0261627 Filialumgliederung (P1760) alle Filialen werden in den Views von wup_id auf aktuell_wup_id umgemappt
--							  somit im Frontend nur die neue ID, auch alte Bewegungsdaten werden ab Umgliederungsdatum unter der neuen ID angzeigt 

SELECT

v01.pruefung_id,
v01.amx_system_id, -- DE-Prüfungen werden ab 2023 ausschließlich im AMX-Core erfasst
v01.pruefung_nr, 
v01.zustand_id, 
v01.pruefung_bez, 
v01.dat_start, 
v01.dat_ende, 
v01.revisor_id, 
v01.pruefung_typ_id, 
v01.pruefung_klasse_id,
v01.pruefung_ergebnis_wert, -- DE-Prüfungen werden ab 2023 ausschließlich im AMX-Core erfasst, daher keine Werte für amx_system_id = 2 (Unternehmenssicherheit)
v01.pruefung_ergebnis_wert_oneamx,
v01.business_unit_id, 
v01.mandant_id, 
v03.aktuell_wup_id AS wup_id,
v03.nb_id,
v01.zeitspanne, -- In DE-Tabellen ist keine Zeitspanne erfasst
v01.sec_kz

FROM

(SELECT
 pruefung_id
,amx_system_id
,pruefung_nr
,zustand_id
,pruefung_bez
,dat_start
,dat_ende
,revisor_id
,pruefung_typ_id
,pruefung_klasse_id
,CASE WHEN amx_system_id = 2 THEN pruefung_ergebnis_wert ELSE 0 END AS pruefung_ergebnis_wert
,CASE WHEN amx_system_id = 1 THEN pruefung_ergebnis_wert ELSE 0 END AS pruefung_ergebnis_wert_oneamx
,business_unit_id
,mandant_id
,CASE WHEN wup_id = -1 THEN 0 ELSE wup_id END AS wup_id --ablösen durch BED 
,CASE WHEN zeitspanne = '-1' THEN '' ELSE zeitspanne END AS zeitspanne
,6 ::BYTEINT AS sec_kz

FROM dbp_view.v_amx_pruefung_1 

--separate Tabelle mit DE Daten:
UNION

SELECT 
pruefung_id,
1 AS amx_system_id, -- DE-Prüfungen werden ab 2023 ausschließlich im AMX-Core erfasst
pruefung_nr, 
zustand_id, 
pruefung_bez, 
dat_start, 
dat_ende, 
revisor_id, 
pruefung_typ_id, 
pruefung_klasse_id,
0 AS pruefung_ergebnis_wert, -- DE-Prüfungen werden ab 2023 ausschließlich im AMX-Core erfasst, daher keine Werte für amx_system_id = 2 (Unternehmenssicherheit)
pruefung_ergebnis_wert AS pruefung_ergebnis_wert_oneamx,
business_unit_id, 
mandant_id, 
CASE WHEN wup_id = -1 THEN 0 ELSE wup_id END AS wup_id, --ablösen durch BED
'' AS zeitspanne, -- In DE-Tabellen ist keine Zeitspanne erfasst
6 ::BYTEINT AS sec_kz

FROM dbp_view.v_amx_de_pruefung_1) v01

LEFT OUTER JOIN
( --Ermittlung aller Prüfungen die mindestens einen Prüfprozess zum Thema Arbeitsschutz AS oder Gesundheitsschutz GS zugeordnet haben
SELECT DISTINCT
pruefung_id -- Prüfung kann mehreren Prozessen zugeordnet sein
,amx_system_id
,1 AS asgs_flag --Flag, dass Prüfung zu AS oder GS gehört 
FROM dbp_view.v_amx_b_process_pruefung_zu_1

WHERE ((amx_system_id = 2 AND business_process_id IN (102803,117032,102805))
OR (amx_system_id = 1 AND business_process_id IN (544687,544691,544689))) --AS und GS

UNION -- Tabelle für DE

SELECT DISTINCT
pruefung_id -- Prüfung kann mehreren Prozessen zugeordnet sein
,1 AS amx_system_id -- DE-Prüfungen werden ab 2023 ausschließlich im AMX-Core erfasst
,1 AS asgs_flag --Flag, dass Prüfung zu AS oder GS gehört 
FROM dbp_view.v_amx_de_b_process_pruefung_zu_1

WHERE (business_process_id IN (544687,544691,544689)) --AS und GS
) v02
ON v01.pruefung_id = v02.pruefung_id
AND v01.amx_system_id = v02.amx_system_id

--nb_id ermitteln, weil im Attribut als Schlüsselfeld
LEFT OUTER JOIN dbp_view.v_wup_1 v03
ON v01.wup_id = v03.wup_id
AND v01.mandant_id = v03.mandant_id

WHERE  ((v01.amx_system_id = 2 AND v01.zustand_id IN (100003, 100004, 100005, 1001, 100025))
OR (v01.amx_system_id = 1 AND v01.zustand_id IN (100005,1001,100041)))  --nur diese relevant für audimex 

   AND -- je Land_1 Daten ab bestimmten Datum auswerten (Einführung audimex) bzw. bei DE noch unterschieden nach Prozessen. Daten zuvor sind nicht komplett
   (
   (v01.mandant_id = 1 AND asgs_flag = 1 AND dat_ende >= CAST('2015-03-01' AS DATE)) OR (v01.mandant_id = 1 AND asgs_flag IS NULL AND dat_ende >= CAST('2015-06-01' AS DATE)) OR
   (v01.mandant_id = 2 AND dat_ende >= CAST('2015-03-01' AS DATE)) OR (v01.mandant_id = 3 AND dat_ende >= CAST('2015-06-22' AS DATE)) OR (v01.mandant_id = 4 AND dat_ende >= CAST('2019-10-31' AS DATE) ) OR
   (v01.mandant_id = 5 AND dat_ende >= CAST('2015-07-16' AS DATE)) OR (v01.mandant_id = 6 AND dat_ende >= CAST('2015-10-29' AS DATE)) OR (v01.mandant_id = 7 AND dat_ende >= CAST('2015-12-01' AS DATE)) OR
   (v01.mandant_id = 8 AND dat_ende >= CAST('2015-12-01' AS DATE))
   )
;