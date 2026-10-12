CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KMR_FILIALBEWERTUNG_GESAMT_2(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	KJMO,
	KMR_GESAMT_ANZAHL,
	KMR_GESAMT_OK,
	KMR_GESAMT_NOK,
	KMR_GESAMT_GES
) AS 

/*	FAKT DENORM : Kurzcheck - Filialbewertung Gesamtbewertung
	Kombination aus altem Kurzcheck/AMX bis 2024-07 & neuem Kurzcheck/KMR ab 2024-08
	2024-11-19 Initial. Ohne DE [AP0237709]
*/
 
 
/* Kurzcheck KMR -- neue Version ab 2024-08 */ 
SELECT 
  kmr.mandant_id
, kmr.nb_id 
, kmr.wup_id
, zeit.kjmo
, COUNT(DISTINCT kmr.pruefung_id) AS kmr_gesamt_pruefung /* Anzahl Prüfungen*/
, SUM(kmr.ergebnis_ok)            AS kmr_gesamt_ok  /* Anzahl OK */ 
, SUM(kmr.ergebnis_nok)           AS kmr_gesamt_nok /* Anzahl Nicht OK */ 
, SUM(kmr.ergebnis_anz)           AS kmr_gesamt_anz /* NOK% = kmr_gesamt_nok / kmr_gesamt_anz */
FROM ( /* Kurzcheck Basisabfrage.Filterung auf relevante Daten inkl Mapping aktuell_wup */
	SELECT
	  wup.mandant_id                 AS mandant_id
	, wup.nb_id                      AS nb_id 
	, wup.aktuell_wup_id             AS wup_id 
	, kmr_prf.dat_pruef_zeitraum_bis AS dat     /* Pruefung abgeschlossen */
	, kmr_frg.sort_nr                AS sort_nr /* Basisfeld Frage */
	, SUBSTR(kmr_frg.sort_nr, 12, 4) ::INTEGER AS frage_nr     /* relevante Kurzform Frage*/
	, SUBSTR(kmr_frg.sort_nr, 14, 2) ::INTEGER AS bereich_nr   /* Bereich/Hauptbereich */
	, SUBSTR(kmr_frg.sort_nr, 12, 2) ::INTEGER AS kategorie_nr /* Kategorie/Unterkategorie */
	, kmr_frg.ergebnis_num  /* Ergebnis Helper */
	, kmr_frg.ergebnis_text /* Ergebnis Text */
	, CASE WHEN kmr_frg.ergebnis_num =  0 THEN 1 ELSE 0 END AS ergebnis_ok  /* Pruefung/Frage OK */
	, CASE WHEN kmr_frg.ergebnis_num =  1 THEN 1 ELSE 0 END AS ergebnis_nok /* Pruefung/Frage Nicht OK */
	, CASE WHEN kmr_frg.ergebnis_num >= 0 THEN 1 ELSE 0 END AS ergebnis_anz /* Pruefung durchgeführt / Frage beantwortet */
	, CASE WHEN kmr_frg.ergebnis_num = -1 THEN 1 ELSE 0 END AS ergebnis_na  /* Pruefung nicht durchgeführt / Frage nicht beantwortet */
	, kmr_kap.pruefung_id 
	FROM DBP_VIEW.V_KMR_FRAGE_2 kmr_frg
	INNER JOIN DBP_VIEW.V_KMR_PRUEFPROGRAMM_KAPITEL_2 kmr_kap
	ON kmr_kap.kapitel_id = kmr_frg.kapitel_id AND kmr_kap.amx_system_id = kmr_frg.amx_system_id
	INNER JOIN DBP_VIEW.V_KMR_PRUEFUNG_2 kmr_prf
	ON kmr_prf.pruefung_id = kmr_kap.pruefung_id AND kmr_prf.amx_system_id = kmr_kap.amx_system_id
	INNER JOIN DBP_VIEW.V_KMR_L_PRUEFUNG_KLASSE_2 kmr_lpk
	ON kmr_lpk.pruefung_klasse_id = kmr_prf.pruefung_klasse_id AND kmr_lpk.amx_system_id = kmr_prf.amx_system_id
	INNER JOIN DBP_VIEW.V_KMR_L_PRUEFUNG_STATUS_2 kmr_lps
	ON kmr_lps.pruefung_status_id = kmr_prf.pruefung_status_id AND kmr_lps.amx_system_id = kmr_prf.amx_system_id
	INNER JOIN DBP_VIEW.V_KMR_L_ORGANISATIONSEINHEIT_2 kmr_loe
	ON kmr_loe.orga_einheit_id = kmr_prf.gepr_oe_id AND kmr_loe.amx_system_id = kmr_prf.amx_system_id
	INNER JOIN  dbp_view.v_wup_2 wup_2
	ON wup.wup_id = kmr_loe.wup_id AND wup.mandant_id = kmr_loe.mandant_id
	INNER JOIN DBP_VIEW.V_KMR_L_PRUEFPROZESS_2 kmr_lpp
	ON kmr_lpp.gepr_prozess_id = kmr_kap.gepr_prozess_id AND kmr_lpp.amx_system_id = kmr_kap.amx_system_id
	WHERE kmr_frg.amx_system_id = 1                    /* One Audimex */
	AND kmr_prf.pruefung_klasse_id IN (100003)         /* Kurzcheck */
	AND kmr_prf.pruefung_status_id IN (100005, 100041) /* Bericht versandt, Bericht versandt* */
	/* Filter auf Kategorie/Bereich, funktioniert nur mit Try auf Textfeld ohne Fehler */
	AND TRY_TO_NUMBER(SUBSTR(kmr_frg.sort_nr, 12, 4)) = 0 /* Filialbewertung Gesamt */
	AND wup.mandant_id <> 1 /* ohne DE */
) kmr
INNER JOIN DBP_DATA.TAG_2 zeit_2
ON zeit.dat = kmr.dat
GROUP BY ALL 
 
/* Kurzcheck One Audimex -- Alte Version bis 2024-07 */ 
UNION ALL
SELECT 
  amx.mandant_id
, amx.nb_id 
, amx.wup_id
, zeit.kjmo 
, COUNT(DISTINCT amx.pruefung_id) AS kmr_gesamt_pruefung /* Anzahl Prüfungen*/
, SUM(antwort_ok)                 AS kmr_gesamt_ok  /* Anzahl OK */ 
, SUM(antwort_nok)                AS kmr_gesamt_nok /* Anzahl Nicht OK */ 
, SUM(antwort_ges)                AS kmr_gesamt_anz /* NOK% = kmr_gesamt_nok / kmr_gesamt_anz */
FROM ( 
	SELECT wup.mandant_id, wup.nb_id, wup.aktuell_wup_id AS wup_id
	, amx_prf.dat_ende, amx_prf.pruefung_id
	, CASE WHEN amx_frg.antwort_wert IN (1,4)   THEN 1 ELSE 0 END antwort_nok
	, CASE WHEN amx_frg.antwort_wert IN (0)     THEN 1 ELSE 0 END antwort_ok
	, CASE WHEN amx_frg.antwort_wert IN (0,1,4) THEN 1 ELSE 0 END antwort_ges
	FROM ( /* Fragen mit relevanten Antworten (0, 1, 4) */
		SELECT amx_frage_id, pruef_kapitel_id, antwort_wert, amx_frage_katalog_id FROM dbp_view.v_amx_frage_2
		WHERE amx_system_id=1 AND antwort_wert IN (0, 1, 4) /* System = One Audimex */
	) amx_frg
	INNER JOIN ( /* Fragenkatalog für Filialbewertung Gesamtbewerttung */
		SELECT amx_frage_katalog_id, hauptbereich_id, teilbereich_id, amx_handlung_typ_id FROM dbp_view.v_amx_frage_katalog_2 
		WHERE amx_system_id = 1 /* System = One Audimex */
		AND hauptbereich_id = 597230 /* Filialbewertung */
		AND teilbereich_id = 597253 /* Gesambewertung */
		AND amx_handlung_typ_id IN (1, 50000) /* Bewertungsfrage, Zählfrage */
		AND SUBSTR(frage_nr, 6, 25) NOT IN ( /* Relevante Fragen (nur für Cockpit) */
			SELECT platzhalter_string FROM dbp_view.v_amx_filter_benutzeroberflaeche_2
			WHERE amx_system_id = 1 AND amx_filter_typ_id = 3) 
	) amx_kat 
	ON amx_kat.amx_frage_katalog_id = amx_frg.amx_frage_katalog_id 
	INNER JOIN ( /* Prüfkapitel */
		SELECT pruef_kapitel_id, pruefung_id FROM dbp_view.v_amx_pruef_kapitel_2
		WHERE amx_system_id = 1 /* System = One Audimex */
	) amx_kap
	ON amx_frg.pruef_kapitel_id = amx_kap.pruef_kapitel_id
	INNER JOIN ( /* Bussiness Prozess gefiltert : Audimex One - K Kurzcheck */
		SELECT business_process_id, pruefung_id 
		FROM dbp_view.v_amx_b_process_pruefung_zu_2
		WHERE amx_system_id = 1 /* System 1 = One Audimex */
		AND business_process_id = 544687 /* Prozess = K_Kurzcheck */
	) amx_bpp
	ON amx_bpp.pruefung_id = amx_kap.pruefung_id 
	INNER JOIN ( /* Prüfung gefiltert */
		SELECT mandant_id, wup_id, pruefung_id, dat_ende
		FROM dbp_view.v_amx_pruefung_2
		WHERE amx_system_id = 1 /* System = One Audimex */
		AND zustand_id IN (100003, 100004, 100005, 1001, 100025, 100041) /* Relevante Zustände */
	) amx_prf
	ON amx_prf.pruefung_id = amx_kap.pruefung_id 
	INNER JOIN DBP_DATA.WUP_2 wup_2
	ON wup.wup_id = amx_prf.wup_id AND wup.mandant_id = amx_prf.mandant_id
	WHERE wup.mandant_id <> 1 
) amx 
INNER JOIN DBP_DATA.TAG_2 zeit_2
ON zeit.dat = amx.dat_ende
GROUP BY ALL
;