CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KMR_KURZCHECK_ERGEBNIS_1 (
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	DAT,
	KMR_PRUEFUNG_NR,
	KMR_SORT_NR,
	KMR_FRAGE_NR,
	KMR_BEREICH_NR,
	KMR_KATEGORIE_NR,
	KMR_ERGEBNIS_OK,
	KMR_ERGEBNIS_NOK,
	KMR_ERGEBNIS_ANZ,
	KMR_ERGEBNIS_NA
) AS 
 
/*	FAKT DENORM : KMR Kurzcheck - neue Version ab 2024-08
	2024-11-19 Initial. Aggregation auf Bereich/Kategorie. Mapping auf GF_1/DE [AP0237709]
	
*/
 
WITH kmr AS ( /* CTE : Basisabfrage, Filterung auf relevante Daten inkl Mapping aktuell_wup */ 
	SELECT
	  wup.mandant_id                 AS mandant_id
	, wup.nb_id                      AS nb_id 
	, wup.aktuell_wup_id             AS wup_id 
	, wup.gf_id                      AS gf_id
	, kmr_prf.dat_pruef_zeitraum_bis AS dat     /* Prüfung abgeschlossen */
	, kmr_frg.sort_nr                AS sort_nr /* Basisfeld Frage */
	, SUBSTR(kmr_frg.sort_nr, 12, 4) ::INTEGER AS frage_nr     /* Frage relevante Kurzform (international) */
	, SUBSTR(kmr_frg.sort_nr, 14, 2) ::INTEGER AS bereich_nr   /* Bereich/Hauptbereich */
	, SUBSTR(kmr_frg.sort_nr, 12, 2) ::INTEGER AS kategorie_nr /* Kategorie/Unterkategorie */
	, kmr_frg.ergebnis_num  /* Ergebnis Helper */
	, kmr_frg.ergebnis_text /* Ergebnis Text */
	, CASE WHEN kmr_frg.ergebnis_num =  0 THEN 1 ELSE 0 END AS ergebnis_ok  /* Prüfung + Frage mit OK beantwortet */
	, CASE WHEN kmr_frg.ergebnis_num =  1 THEN 1 ELSE 0 END AS ergebnis_nok /* Prüfung + Frage mit Nicht OK beantwortet */
	, CASE WHEN kmr_frg.ergebnis_num >= 0 THEN 1 ELSE 0 END AS ergebnis_anz /* Prüfung durchgeführt + Frage beantwortet*/
	, CASE WHEN kmr_frg.ergebnis_num = -1 THEN 1 ELSE 0 END AS ergebnis_na  /* Prüfung nicht durchgeführt, Frage nicht beantwortet */
	, kmr_frg.frage_id 
	, kmr_kap.kapitel_id 
	, kmr_kap.sort_nr AS kapitel_sort_nr 
	, kmr_kap.gepr_prozess_id 
	, kmr_kap.pruefung_id 
	, kmr_prf.pruefung_nr
	, kmr_prf.pruefung_bez
	, kmr_prf.pruefung_status_id 
	, kmr_prf.tageszeit_id 
	, kmr_prf.pruefung_klasse_id 
	, kmr_prf.gepr_oe_id AS orga_einheit_id
	FROM DBP_VIEW.V_KMR_FRAGE_1 kmr_frg
	INNER JOIN DBP_VIEW.V_KMR_PRUEFPROGRAMM_KAPITEL_1 kmr_kap
	ON kmr_kap.kapitel_id = kmr_frg.kapitel_id AND kmr_kap.amx_system_id = kmr_frg.amx_system_id
	INNER JOIN DBP_VIEW.V_KMR_PRUEFUNG_1 kmr_prf
	ON kmr_prf.pruefung_id = kmr_kap.pruefung_id AND kmr_prf.amx_system_id = kmr_kap.amx_system_id
	INNER JOIN DBP_VIEW.V_KMR_L_PRUEFUNG_KLASSE_1 kmr_lpk
	ON kmr_lpk.pruefung_klasse_id = kmr_prf.pruefung_klasse_id AND kmr_lpk.amx_system_id = kmr_prf.amx_system_id
	INNER JOIN DBP_VIEW.V_KMR_L_PRUEFUNG_STATUS_1 kmr_lps
	ON kmr_lps.pruefung_status_id = kmr_prf.pruefung_status_id AND kmr_lps.amx_system_id = kmr_prf.amx_system_id
	INNER JOIN DBP_VIEW.V_KMR_L_ORGANISATIONSEINHEIT_1 kmr_loe
	ON kmr_loe.orga_einheit_id = kmr_prf.gepr_oe_id AND kmr_loe.amx_system_id = kmr_prf.amx_system_id
	INNER JOIN  dbp_view.v_wup_1 wup_1
	ON wup.wup_id = kmr_loe.wup_id AND wup.mandant_id = kmr_loe.mandant_id
	INNER JOIN DBP_VIEW.V_KMR_L_PRUEFPROZESS_1 kmr_lpp
	ON kmr_lpp.gepr_prozess_id = kmr_kap.gepr_prozess_id AND kmr_lpp.amx_system_id = kmr_kap.amx_system_id
	INNER JOIN DBP_VIEW.V_KMR_L_TAGESZEIT_1 kmr_ltz
	ON kmr_ltz.tageszeit_id = kmr_prf.tageszeit_id AND kmr_ltz.amx_system_id = kmr_prf.amx_system_id
	WHERE kmr_frg.amx_system_id = 1                    /* OneAudimex */
	AND kmr_prf.pruefung_klasse_id IN (100003)         /* Kurzcheck */
	AND kmr_prf.pruefung_status_id IN (100005, 100041) /* Bericht versandt, Bericht versandt* */
) /* CTE Ende */
 
 
/* PART 1 : Einzelfragen pro Kategorie und Bereich inkl. Filialbewertung Gesamt - AUSLAND */ 
SELECT 
  kmr.mandant_id
, kmr.nb_id
, kmr.wup_id
, kmr.dat 
, kmr.pruefung_nr  AS kmr_pruefung_nr
, kmr.sort_nr      AS kmr_sort_nr
, kmr.frage_nr     AS kmr_frage_nr 
, kmr.bereich_nr   AS kmr_bereich_nr
, kmr.kategorie_nr AS kmr_kategorie_nr
, SUM(kmr.ergebnis_ok)  AS kmr_ergebnis_ok
, SUM(kmr.ergebnis_nok) AS kmr_ergebnis_nok
, SUM(kmr.ergebnis_anz) AS kmr_ergebnis_anz
, SUM(kmr.ergebnis_na)  AS kmr_ergebnis_na
FROM kmr
WHERE mandant_id > 1 
GROUP BY ALL 
 
/* PART 2 : Aggregation pro Bereich auf Kategorie Gesamt (Gesamtbewertung) - ohne Filialbewertung Gesamt - AUSLAND */ 
UNION ALL SELECT 
  kmr.mandant_id
, kmr.nb_id 
, kmr.wup_id
, kmr.dat 
, kmr.pruefung_nr       AS kmr_pruefung_nr
, LEFT(kmr.sort_nr,11) || '00' || RIGHT(kmr.sort_nr,5) AS kmr_sort_nr /* Pseudo Nr mit Kategorie 00 */
, kmr.bereich_nr        AS kmr_frage_nr /* Frage = Bereich ohne fhrende 00 */
, kmr.bereich_nr        AS kmr_bereich_nr 
, 0                     AS kmr_kategorie_nr
, SUM(kmr.ergebnis_ok)  AS kmr_ergebnis_ok
, SUM(kmr.ergebnis_nok) AS kmr_ergebnis_nok
, SUM(kmr.ergebnis_anz) AS kmr_ergebnis_anz
, SUM(kmr.ergebnis_na)  AS kmr_ergebnis_na
FROM kmr
WHERE mandant_id > 1 
AND TRY_TO_NUMBER(SUBSTR(kmr.sort_nr, 12, 4)) > 0 /* funktioniert nur mit Try/Original Textfeld ohne Fehler */
GROUP BY ALL 
 
/* Part 3 : Aggregation pro Kategorie auf Bereich Filiale (Filialbewertung) - ohne Filialbewertung Gesamt - AUSLAND */ 
UNION ALL SELECT 
  kmr.mandant_id
, kmr.nb_id
, kmr.wup_id
, kmr.dat 
, kmr.pruefung_nr  AS kmr_pruefung_nr
, LEFT(kmr.sort_nr,13) || '00' || RIGHT(kmr.sort_nr,3) AS kmr_sort_nr /* Pseudo Nr mit Bereich 00 */
, kmr.kategorie_nr * 100 AS kmr_frage_nr /* Frage = Kategorie * 100 */
, 0                      AS kmr_bereich_nr
, kmr.kategorie_nr       AS kmr_kategorie_nr
, SUM(kmr.ergebnis_ok)   AS kmr_ergebnis_ok
, SUM(kmr.ergebnis_nok)  AS kmr_ergebnis_nok
, SUM(kmr.ergebnis_anz)  AS kmr_ergebnis_anz
, SUM(kmr.ergebnis_na)   AS kmr_ergebnis_na
FROM kmr
WHERE mandant_id > 1 
AND try_to_number(SUBSTR(kmr.sort_nr, 12, 4)) > 0 /* funktioniert nur mit Try/Original Textfeld ohne Fehler */
GROUP BY ALL 
 
/* PART 4 : Einzelfragen pro Kategorie und Bereich inkl. Filialbewertung Gesamt - DE */ 
UNION ALL SELECT 
  kmr.mandant_id
, -1 ::INTEGER AS nb_id
, kmr.gf_id    AS wup_id
, kmr.dat 
, kmr.pruefung_nr  AS kmr_pruefung_nr
, kmr.sort_nr      AS kmr_sort_nr
, kmr.frage_nr     AS kmr_frage_nr 
, kmr.bereich_nr   AS kmr_bereich_nr
, kmr.kategorie_nr AS kmr_kategorie_nr
, SUM(kmr.ergebnis_ok)  AS kmr_ergebnis_ok
, SUM(kmr.ergebnis_nok) AS kmr_ergebnis_nok
, SUM(kmr.ergebnis_anz) AS kmr_ergebnis_anz
, SUM(kmr.ergebnis_na)  AS kmr_ergebnis_na
FROM kmr
WHERE mandant_id = 1 
GROUP BY ALL 
 
/* PART 5 : Aggregation pro Bereich auf Kategorie Gesamt (Gesamtbewertung) - ohne Filialbewertung Gesamt - DE */ 
UNION ALL SELECT 
  kmr.mandant_id
, -1 ::INTEGER AS nb_id
, kmr.gf_id    AS wup_id
, kmr.dat 
, kmr.pruefung_nr       AS kmr_pruefung_nr
, LEFT(kmr.sort_nr,11) || '00' || RIGHT(kmr.sort_nr,5) AS kmr_sort_nr /* Pseudo Nr mit Kategorie 00 */
, kmr.bereich_nr        AS kmr_frage_nr /* Frage = Bereich ohne fhrende 00 */
, kmr.bereich_nr        AS kmr_bereich_nr 
, 0                     AS kmr_kategorie_nr
, SUM(kmr.ergebnis_ok)  AS kmr_ergebnis_ok
, SUM(kmr.ergebnis_nok) AS kmr_ergebnis_nok
, SUM(kmr.ergebnis_anz) AS kmr_ergebnis_anz
, SUM(kmr.ergebnis_na)  AS kmr_ergebnis_na
FROM kmr
WHERE mandant_id = 1 
AND TRY_TO_NUMBER(SUBSTR(kmr.sort_nr, 12, 4)) > 0 /* funktioniert nur mit Try/Original Textfeld ohne Fehler */
GROUP BY ALL 
 
/* Part 6 : Aggregation pro Kategorie auf Bereich Filiale (Filialbewertung) - ohne Filialbewertung Gesamt - DE */ 
UNION ALL SELECT 
  kmr.mandant_id
, -1 ::INTEGER AS nb_id
, kmr.gf_id    AS wup_id
, kmr.dat 
, kmr.pruefung_nr  AS kmr_pruefung_nr
, LEFT(kmr.sort_nr,13) || '00' || RIGHT(kmr.sort_nr,3) AS kmr_sort_nr /* Pseudo Nr mit Bereich 00 */
, kmr.kategorie_nr * 100 AS kmr_frage_nr /* Frage = Kategorie * 100 */
, 0                      AS kmr_bereich_nr
, kmr.kategorie_nr       AS kmr_kategorie_nr
, SUM(kmr.ergebnis_ok)   AS kmr_ergebnis_ok
, SUM(kmr.ergebnis_nok)  AS kmr_ergebnis_nok
, SUM(kmr.ergebnis_anz)  AS kmr_ergebnis_anz
, SUM(kmr.ergebnis_na)   AS kmr_ergebnis_na
FROM kmr
WHERE mandant_id = 1 
AND try_to_number(SUBSTR(kmr.sort_nr, 12, 4)) > 0 /* funktioniert nur mit Try/Original Textfeld ohne Fehler */
GROUP BY ALL 
;