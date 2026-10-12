CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AMX_PRUEFUNG_2(
   PRUEFUNG_ID,
	PRUEFUNG_NR,
	ZUSTAND_ID,
	PRUEFUNG_BEZ,
	DAT_START,
	DAT_ENDE,
	REVISOR_ID,
	PRUEFUNG_TYP_ID,
	PRUEFUNG_KLASSE_ID,
	PRUEFUNG_ERGEBNIS_WERT,
	BUSINESS_UNIT_ID,
	MANDANT_ID,
	WUP_ID
)
AS
-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20160324 twie: Filterung auf zustand_id gilt global für audimex
-- 20160506 twie: zeitlich begrenzt, ab wann Daten ausgewertet werden, pro Land_2
-- 20160520 twie: wup_id -1 zu 0, weil so in wup_2 Tabelle
-- 20190109 twie: NSR0506061 Filter zustand_id erweitert um 100025
-- 20190828 twie: SPEC0059325 Filterung auf Business Prozess
-- 20191008 twie: SPEC0059324 für dt. AMX Daten temporär eine_2 weitere Tabelle mit manuell befüllten Daten per Union anbinden
-- 20200211 twie: SPEC0067890 Tabellenname für dt. AMX Daten ersetzen
-- 20200326 lsvi: SPEC0073867 OneAudimex filter amx_system_id=1
-- 20200727 ssch0611 : AP0044665 OneAudimex - added zustand_id 100041 
-- 2024-06-20 muellerpatri : Filialumgliederung + Review [P1760-DWH]
SELECT 
   v01.pruefung_id
   , v01.pruefung_nr
   , v01.zustand_id
   , v01.pruefung_bez
   , v01.dat_start
   , v01.dat_ende
   , v01.revisor_id
   , v01.pruefung_typ_id
   , v01.pruefung_klasse_id
   , v01.pruefung_ergebnis_wert
   , v01.business_unit_id
   , v01.mandant_id
   , wup.aktuell_wup_id AS wup_id
FROM
(
   SELECT pruefung_id, pruefung_nr, zustand_id, pruefung_bez, dat_start, dat_ende, revisor_id, pruefung_typ_id, pruefung_klasse_id, pruefung_ergebnis_wert, business_unit_id, mandant_id, wup_id
   FROM dbp_view.v_amx_pruefung_2
   WHERE amx_system_id=1

   UNION
   
   SELECT pruefung_id, pruefung_nr, zustand_id, pruefung_bez, dat_start, dat_ende, revisor_id, pruefung_typ_id, pruefung_klasse_id, pruefung_ergebnis_wert, business_unit_id, mandant_id, wup_id
   FROM dbp_view.v_amx_de_pruefung_2
) v01

INNER JOIN
(
   SELECT business_process_id, pruefung_id
   FROM dbp_view.v_amx_b_process_pruefung_zu_2
   WHERE amx_system_id=1
   
   UNION

   SELECT business_process_id, pruefung_id
   FROM dbp_view.v_amx_de_b_process_pruefung_zu_2
) v02
ON v01.pruefung_id = v02.pruefung_id
AND v02.business_process_id = 544687  --FR_Kurzcheck

INNER JOIN dbp_view.v_wup_2 wup_2
ON v01.mandant_id = wup.mandant_id AND CASE WHEN v01.wup_id = -1 THEN 0 ELSE v01.wup_id END  = wup.wup_id

WHERE --nur diese relevant für audimex
zustand_id IN (100003, 100004, 100005, 1001, 100025, 100041);