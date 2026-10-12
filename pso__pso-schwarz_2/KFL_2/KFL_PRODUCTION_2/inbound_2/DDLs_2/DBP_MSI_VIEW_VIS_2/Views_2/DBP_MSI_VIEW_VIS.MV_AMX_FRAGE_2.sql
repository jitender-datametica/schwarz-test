CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AMX_FRAGE_2(
	AMX_FRAGE_ID,
	PRUEF_KAPITEL_ID,
	ANTWORT_WERT,
	AMX_FRAGE_KATALOG_ID,
	KMR_QUELLE_ID,
	ANMERKUNG,
	EINGABE,
	ANZ_FEHLER_AMX,
	STICHPROBE_UMFANG,
	DAT_ENDE
) AS
 
/*	AMX FRAGE : Kurzcheck Fragen
	20160322 KKaiser, neu für AP0002158 Audimex
	20160506 twie: zeitlich begrenzt, ab wann Daten ausgewertet werden, pro Land_2
	20160923 twie: SPEC0013335 4 neue Felder, Viewfilterung auf antwort_wert 0 (ohne) und 4 (mit Feststellung) entfernt, alle Fragen sollen auswertbar sein. Betrifft nur flex. Bericht (Quote und Zufa haben entspr. Metrikfilter)
	20180625 lsvi: SPEC0038139 analog KMR Schlüssel für Fragekatalog um kmr_quelle_id ergänzt für Zusammenführung Hierarchie
	20190109 twie: NSR0506061 Filter zustand_id erweitert um 100025
	20190121 twie: SPEC0048887 Filterung antwort_wert ergänzt um Wert 1 für 'mit Feststellung'
	20190821 twie: SPEC0059325 Datum zur Frage ausgeben, dieses ist in der Prüfung hinterlegt. Da Auswertungsebene für die Metriken aber die Frage ist, wird das Datum hier benötigt
	20190828 twie: SPEC0059325 Nur relevante Fragen für das Cockpit anzeigen, dafür Substrings der Fragenr. aus Filtertabelle ausschließen, sowie Filterung auf Business Prozess
	20191008 twie: SPEC0059324 für dt. AMX Daten temporär eine_2 weitere Tabelle mit manuell befüllten Daten per Union anbinden
	20200211 twie: SPEC0067890 Tabellenname für dt. AMX Daten ersetzen
	20200326 lsvi: SPEC0073867 OneAudimex filter amx_system_id=1
	20200727 ssch0611 : AP0044665 OneAudimex - added zustand_id 100041 
 
	2024-01-23 INC7947217 : Neuer Filter auf Fragekatalog/Hauptbereich 
*/
 
SELECT 
  v01.amx_frage_id
, v01.pruef_kapitel_id
, v01.antwort_wert
, v01.amx_frage_katalog_id
, 1 AS kmr_quelle_id
, v01.anmerkung
/* Eingabe nur anzeigen, wenn Antwort nicht 0, 1 oder 4 (ohne/mit Feststellung) */
, CASE WHEN v01.antwort_wert IN (0, 1, 4) THEN '' ELSE v01.eingabe END AS eingabe
, v01.anz_fehler_amx
, v01.stichprobe_umfang
, v03.dat_ende
FROM (
	SELECT amx_frage_id, pruef_kapitel_id, antwort_wert, amx_frage_katalog_id, anmerkung, eingabe, anz_fehler_amx, stichprobe_umfang, frage_gewichtung, antwort_wert_text 
	FROM dbp_view.v_amx_frage_2
	WHERE amx_system_id=1
	UNION ALL /* Daten DE */
	SELECT amx_frage_id, pruef_kapitel_id, antwort_wert, amx_frage_katalog_id, anmerkung, eingabe, anz_fehler_amx, stichprobe_umfang, frage_gewichtung, antwort_wert_text
	FROM dbp_view.v_amx_de_frage_2
) v01
 
INNER JOIN (
	SELECT pruef_kapitel_id, pruefung_id, pruef_kapitel_bez, hauptbereich_id, teilbereich_id, kapitel_ergebnis_wert
	FROM dbp_view.v_amx_pruef_kapitel_2
	WHERE amx_system_id = 1 /* System 1 = One Audimex */
	UNION ALL /* Daten DE */
	SELECT pruef_kapitel_id, pruefung_id, pruef_kapitel_bez, hauptbereich_id, teilbereich_id, kapitel_ergebnis_wert
	FROM dbp_view.v_amx_de_pruef_kapitel_2
) v02
ON v01.pruef_kapitel_id = v02.pruef_kapitel_id
 
INNER JOIN (
	SELECT  pruefung_id, pruefung_nr, zustand_id, pruefung_bez, dat_start, dat_ende, revisor_id, pruefung_typ_id, pruefung_klasse_id, pruefung_ergebnis_wert, business_unit_id, mandant_id, wup_id 
	FROM dbp_view.v_amx_pruefung_2
	WHERE amx_system_id = 1 /* System 1 = One Audimex */
	AND zustand_id IN (100003, 100004, 100005, 1001, 100025, 100041) /* Relevant Zustände für Audimex */
	UNION ALL /* Daten DE */
	SELECT pruefung_id, pruefung_nr, zustand_id, pruefung_bez, dat_start, dat_ende, revisor_id, pruefung_typ_id, pruefung_klasse_id, pruefung_ergebnis_wert, business_unit_id, mandant_id, wup_id 
	FROM dbp_view.v_amx_de_pruefung_2
	WHERE zustand_id IN (100003, 100004, 100005, 1001, 100025, 100041) /* Relevant Zustände für Audimex */
) v03
ON v02.pruefung_id = v03.pruefung_id
 
INNER JOIN ( 
	SELECT business_process_id, pruefung_id 
	FROM dbp_view.v_amx_b_process_pruefung_zu_2
	WHERE amx_system_id = 1 /* System 1 = One Audimex */
	AND business_process_id = 544687 /* Process 544687 = K_Kurzcheck */
	UNION ALL /* Daten DE */
	SELECT business_process_id, pruefung_id 
	FROM dbp_view.v_amx_de_b_process_pruefung_zu_2
	WHERE business_process_id = 544687 /* Process 544687 = K_Kurzcheck */
) v04
ON v03.pruefung_id = v04.pruefung_id 

INNER JOIN ( /* Fragen des zugehörigen Fragekatalogs */
	SELECT amx_frage_katalog_id, hauptbereich_id, teilbereich_id, frage_nr, amx_frage_bez, amx_handlung_typ_id
	FROM dbp_view.v_amx_frage_katalog_2 
	WHERE amx_system_id = 1 /* System 1 = One Audimex */
	AND hauptbereich_id > 0 /* Relevante Hauptbereiche 2024-01 */
	AND SUBSTR(frage_nr, 6, 25) NOT IN ( /* Relevante Fragen (nur für Cockpit) */
		SELECT platzhalter_string FROM dbp_view.v_amx_filter_benutzeroberflaeche_2
		WHERE amx_system_id = 1 AND amx_filter_typ_id = 3 /* Typ = 3 Fragekatalog */
	)
) v05 
ON v01.amx_frage_katalog_id = v05.amx_frage_katalog_id 
;