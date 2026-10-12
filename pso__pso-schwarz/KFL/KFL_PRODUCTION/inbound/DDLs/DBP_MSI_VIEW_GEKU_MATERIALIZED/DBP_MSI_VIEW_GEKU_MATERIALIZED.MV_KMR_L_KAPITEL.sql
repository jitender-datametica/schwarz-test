create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_KMR_L_KAPITEL(
	AMX_SYSTEM_ID,
	PRUEFUNG_ID,
	KAPITEL_ID,
	KAPITEL_NR,
	KAPITEL_TYP_ID,
	SORT_NR,
	FEHLERVERDACHT_FG,
	KAPITEL_BEZ,
	GEPR_PROZESS_ID,
	ERGEBNIS,
	ERGEBNIS_BERECHNET,
	ERGEBNIS_MANUELL
) as
--26.07.2022 twie: SPEC0155060 neue Spezialview, die 4 Entitäten (Prüfprogramm, Haupt-, Teil-, und Unterbereich) in eine vereint (Kapitel)
--                 Kapitel damit ebenfalls Kind von Prüfung, aber ist nicht mehr mit den ursprünglichen 4 Attributen verknüpfbar, sondern nur für einen Spezialbericht gedacht
--                 ACHTUNG, View gehört thematisch nicht zu AMX_ Views des Kurzchecks, sondern zu den audimex Views KMR_, welche inhaltlich und vom Datenmodell komplett getrennt sind
--03.08.2022 twie: kapitel_typ_id eingefügt, um die 4 inhaltlich verschiedenen Typen von Kapitel im Frontend zu unterscheiden. Zugehörige Lookup ist MV_KMR_L_KAPITEL_TYP
--08.11.2022 twie: SPEC0175650 View muss nicht mehr aus den 4 Teilbereichen zusammengesetzt werden sondern es gibt jetzt eine eigene Tabelle für Kapitel

SELECT 

	v01.AMX_SYSTEM_ID,
	v01.PRUEFUNG_ID,
	v01.KAPITEL_ID,
	v01.KAPITEL_NR,
	v01.KAPITEL_TYP_ID,
	v01.SORT_NR,
	v01.FEHLERVERDACHT_FG,
	v01.KAPITEL_BEZ,
	v01.GEPR_PROZESS_ID,
	v01.ERGEBNIS,
	v01.ERGEBNIS_BERECHNET,
	v01.ERGEBNIS_MANUELL

FROM DBP_VIEW.V_KMR_PRUEFPROGRAMM_KAPITEL v01;
