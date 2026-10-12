create or replace TABLE KFL_PRODUCTION.DBP_DATA.KMR_PRUEFPROGRAMM_KAPITEL_2 (
	AMX_SYSTEM_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'AMX-System-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.',
	KAPITEL_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Kapitel-ID. Quellfeld activity_id. Innerhalb eines AMX-Systems die eindeutige ID eines Bereichs. Pruefprogramm, Hauptbereich, Teilbereich, oder Unterbereich.',
	KAPITEL_BEZ VARCHAR(255) DEFAULT ' ' COMMENT 'Kapitel-Bezeichnung, Quellfeld activity_name.',
	KAPITEL_TYP_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Kapiteltyp-ID. Quellfeld audit_universe_audited_process_id_current_level. Zusammen mit dem AMX-System ist es die eindeutige ID des Pruefprogrammtyps: Pruefprogramm, Hauptbereich, Teilbereich, oder Unterbereich.',
	PRUEFUNG_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Prüfungs-ID. Verweist auf kmr_pruefung. Quellfeld auditing_id.',
	KAPITEL_NR VARCHAR(255) DEFAULT ' ' COMMENT 'Kapitelnummer. Quellfeld activity_sort_order.',
	SORT_NR NUMBER(38,0) COMMENT 'Sortiernummer des Kapiteleintrags im Prüfprogramm. Quellfeld program_sort_order.',
	FEHLERVERDACHT_FG NUMBER(38,0) COMMENT 'Flag: Identifizierung fehlerhafter Prüfkapitel  in der Quelle; \"Errechnetes\" Hierarchielevel = 1 -> Bei späteren INCs soll sich Prüfprogramm anschauen, ob fachliche Vorgaben erfüllt sind. Quellfeld has_flawed_audit_program.',
	GEPR_PROZESS_ID NUMBER(38,0) DEFAULT -1 COMMENT 'Geprüfter Prozess-ID. Quellfeld audit_universe_audited_process_id_current_level.',
	ERGEBNIS NUMBER(38,0) COMMENT 'Endergebnis, Quellfeld numeric_result_current_level.',
	ERGEBNIS_BERECHNET NUMBER(38,0) COMMENT 'Ergebnis berechnet. Quellfeld contains_pu_computed_numeric_result_current_level.',
	ERGEBNIS_MANUELL NUMBER(38,0) COMMENT 'Ergebnis manuell. Quellfeld contains_pu_manual_numeric_result_current_level.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_KMR_PRUEFPROGRAMM_KAPITEL primary key (KAPITEL_ID, AMX_SYSTEM_ID)
)COMMENT='KMR - Table for all audit activities (Kapitel der Prüfungen). It contains all \"Prüfprogramme\" (Feld pruefprogramm_id in Tabelle kmr_pruefprogramm_pruefprogramm_2), \"Hauptbereiche\" (Feld hauptbereich_id in Tabelle kmr_pruefprogramm_hauptbereich_2), \"Teilbereiche\" (Feld teilbereich_id in Tabelle kmr_pruefprogramm_teilbereich_2) and \"Unterbereiche\" (Feld unterbereich_id in Tabelle kmr_pruefprogramm_unterbereich_2). Does not contain \"Kurzchecks\". Source view v_dwh_kl_data_audit_program.'
;