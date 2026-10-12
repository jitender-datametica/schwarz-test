CREATE OR REPLACE TABLE kfl_production_dbp_data.kmr_pruefprogramm_kapitel_2 (
amx_system_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='AMX-System-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.'),
kapitel_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Kapitel-ID. Quellfeld activity_id. Innerhalb eines AMX-Systems die eindeutige ID eines Bereichs. Pruefprogramm, Hauptbereich, Teilbereich, oder Unterbereich.'),
kapitel_bez STRING(255) DEFAULT ' ' OPTIONS(description='Kapitel-Bezeichnung, Quellfeld activity_name.'),
kapitel_typ_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Kapiteltyp-ID. Quellfeld audit_universe_audited_process_id_current_level. Zusammen mit dem AMX-System ist es die eindeutige ID des Pruefprogrammtyps: Pruefprogramm, Hauptbereich, Teilbereich, oder Unterbereich.'),
pruefung_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Prüfungs-ID. Verweist auf kmr_pruefung. Quellfeld auditing_id.'),
kapitel_nr STRING(255) DEFAULT ' ' OPTIONS(description='Kapitelnummer. Quellfeld activity_sort_order.'),
sort_nr INTEGER OPTIONS(description='Sortiernummer des Kapiteleintrags im Prüfprogramm. Quellfeld program_sort_order.'),
fehlerverdacht_fg INTEGER
OPTIONS(description='Flag: Identifizierung fehlerhafter Prüfkapitel  in der Quelle;\"Errechnetes\" Hierarchielevel = 1 -> Bei späteren INCs soll sich Prüfprogramm anschauen, ob fachliche Vorgaben erfüllt sind. Quellfeld has_flawed_audit_program.'),
gepr_prozess_id INTEGER DEFAULT - 1
OPTIONS(description='Geprüfter Prozess-ID. Quellfeld audit_universe_audited_process_id_current_level.'),
ergebnis INTEGER OPTIONS(description='Endergebnis, Quellfeld numeric_result_current_level.'),
ergebnis_berechnet INTEGER
OPTIONS(description='Ergebnis berechnet. Quellfeld contains_pu_computed_numeric_result_current_level.'),
ergebnis_manuell INTEGER
OPTIONS(description='Ergebnis manuell. Quellfeld contains_pu_manual_numeric_result_current_level.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (kapitel_id, amx_system_id) NOT ENFORCED
)
OPTIONS(description='KMR - Table for all audit activities (Kapitel der Prüfungen). It contains all\"Prüfprogramme\" (Feld pruefprogramm_id in Tabelle kmr_pruefprogramm_pruefprogramm_2),\"Hauptbereiche\" (Feld hauptbereich_id in Tabelle kmr_pruefprogramm_hauptbereich_2),\"Teilbereiche\" (Feld teilbereich_id in Tabelle kmr_pruefprogramm_teilbereich_2) and\"Unterbereiche\" (Feld unterbereich_id in Tabelle kmr_pruefprogramm_unterbereich_2). Does not contain\"Kurzchecks\". Source view v_dwh_kl_data_audit_program.');