CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AMX_FESTSTELLUNG_1
-- 20160322 KKaiser, neu für AP0002158 Audimex
-- 20160324 twie: hängt nur an Frage, keine Kreisbeziehungen über Prüfung oder Prüfkapitel
-- 20160506 twie: zeitlich begrenzt, ab wann Daten ausgewertet werden, pro Land_1
-- 20160923 twie: SPEC0013335 Viewfilterung auf antwort_wert 0 (ohne) und 4 (mit Feststellung) entfernt, alle Fragen sollen auswertbar sein. Betrifft nur flex. Bericht (Quote und Zufa haben entspr. Metrikfilter)
-- 20190109 twie: NSR0506061 Filter zustand_id erweitert um 100025
-- 20190828 twie: SPEC0059325 Filterung auf Business Prozess
-- 20200416 lsvi: SPEC0073867 OneAudimex filter amx_system_id=1 and business_process_id=544687
-- 20200727 ssch0611 : AP0044665 OneAudimex - added zustand_id 100041 
(
feststellung_id
,amx_frage_id
,feststellung_bez
)
AS 
SELECT 
v01.feststellung_id
,v01.amx_frage_id
,v01.feststellung_bez
FROM dbp_view.v_amx_feststellung_1 v01
INNER JOIN dbp_view.v_amx_frage_1 v02
 ON v01.amx_frage_id = v02.amx_frage_id 
 AND v02.amx_system_id=1
INNER JOIN dbp_view.v_amx_pruef_kapitel_1 v03
 ON v02.pruef_kapitel_id = v03.pruef_kapitel_id 
 AND v03.amx_system_id=1
INNER JOIN dbp_view.v_amx_pruefung_1 v04
 ON v03.pruefung_id = v04.pruefung_id 
 AND v04.amx_system_id=1
INNER JOIN dbp_view.v_amx_b_process_pruefung_zu_1 v05
   ON v04.pruefung_id = v05.pruefung_id
   AND v05.business_process_id = 544687  --FR_Kurzcheck
   AND v05.amx_system_id=1
WHERE  --nur diese relevant für audimex
v04.zustand_id IN (100003, 100004, 100005, 1001, 100025, 100041)
AND v01.amx_system_id=1
;