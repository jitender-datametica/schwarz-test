CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AMX_PRUEF_KAPITEL
-- 20160322 KKaiser, neu für AP0002158 Audimex,hauptbereich_id
-- 20160324 twie: teilbereich_id und hauptbereich_id über amx_frage_katalog ermitteln, nicht über Prüfkapitel
-- 20160506 twie: zeitlich begrenzt, ab wann Daten ausgewertet werden, pro Land
-- 20190109 twie: NSR0506061 Filter zustand_id erweitert um 100025
-- 20190828 twie: SPEC0059325 Filterung auf Business Prozess
-- 20191008 twie: SPEC0059324 für dt. AMX Daten temporär eine weitere Tabelle mit manuell befüllten Daten per Union anbinden
-- 20200211 twie: SPEC0067890 Tabellenname für dt. AMX Daten ersetzen
-- 20200326 lsvi: SPEC0073867 OneAudimex filter amx_system_id=1
-- 20200727 ssch0611 : AP0044665 OneAudimex - added zustand_id 100041 

(
pruef_kapitel_id
,pruefung_id
,pruef_kapitel_bez
,kapitel_ergebnis_wert
)

AS 
SELECT 
v01.pruef_kapitel_id
,v01.pruefung_id
,v01.pruef_kapitel_bez
,v01.kapitel_ergebnis_wert

FROM
(
SELECT pruef_kapitel_id, pruefung_id, pruef_kapitel_bez, hauptbereich_id, teilbereich_id, kapitel_ergebnis_wert
FROM dbp_view.v_amx_pruef_kapitel
WHERE amx_system_id=1

UNION

SELECT pruef_kapitel_id, pruefung_id, pruef_kapitel_bez, hauptbereich_id, teilbereich_id, kapitel_ergebnis_wert
FROM dbp_view.v_amx_de_pruef_kapitel
) v01

INNER JOIN 
(
SELECT pruefung_id, pruefung_nr, zustand_id, pruefung_bez, dat_start, dat_ende, revisor_id, pruefung_typ_id, pruefung_klasse_id, pruefung_ergebnis_wert, business_unit_id, mandant_id, wup_id
FROM dbp_view.v_amx_pruefung
WHERE amx_system_id=1

UNION

SELECT pruefung_id, pruefung_nr, zustand_id, pruefung_bez, dat_start, dat_ende, revisor_id, pruefung_typ_id, pruefung_klasse_id, pruefung_ergebnis_wert, business_unit_id, mandant_id, wup_id
FROM dbp_view.v_amx_de_pruefung
) v02
 ON v01.pruefung_id = v02.pruefung_id

INNER JOIN
(
SELECT business_process_id, pruefung_id
FROM dbp_view.v_amx_b_process_pruefung_zu
WHERE amx_system_id=1

UNION

SELECT business_process_id, pruefung_id
FROM dbp_view.v_amx_de_b_process_pruefung_zu
) v03
   ON v02.pruefung_id = v03.pruefung_id
   AND v03.business_process_id = 544687   --FR_Kurzcheck

WHERE  --nur diese relevant für audimex
v02.zustand_id IN (100003, 100004, 100005, 1001, 100025, 100041);