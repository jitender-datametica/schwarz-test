CREATE OR REPLACE TABLE kfl_production_dbp_data.kmr_frage_2 (
amx_system_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='AMX-System-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.'),
frage_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Frage-ID. Quellfeld guideline_id. Eindeutige ID einer überprüften Frage.'),
kapitel_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Kapitel-ID. Quellfeld activity_id. Eindeutige ID eines Prüfbereichs.'),
sort_nr STRING(255)
OPTIONS(description='Fragennummer. Quellfeld guideline_sort_order. Es ist eine_2 Art_2 ID der Frage im Fragenkatalog einer Landes. Wird diese Frage wieder gestellt / überprüft, hat sie die gleiche sort_nr und frage_text aber eine_2 neue guideline_id.'),
frage_text STRING(50000)
OPTIONS(description='Fragetext. Quellfeld guideline_description_text. Der Text beschreibt den tatsächlichen Gegenstand der Frage, oft in deutscher und Landessprache.'),
anmerkung STRING(50000) OPTIONS(description='Anmerkung zur Frage. Quellfeld guideline_work_description.'),
frage_status_id INTEGER DEFAULT - 1 OPTIONS(description='Status_2-ID. Quellfeld guideline_state_id.'),
frage_typ_id INTEGER DEFAULT - 1 OPTIONS(description='Fragetyp-ID. Quellfeld guideline_checklist_logic_id.'),
stichprobe_umfang INTEGER OPTIONS(description='Stichprobenumfang. Quellfeld guideline_audited_amount.'),
ergebnis_num INTEGER OPTIONS(description='Ergebnis numerisch. Quellfeld guideline_numeric_result.'),
ergebnis_text STRING(255) DEFAULT ' ' OPTIONS(description='Ergebnis textuell. Quellfeld guideline_textual_result.'),
ergebnis_man STRING(1000) OPTIONS(description='Ergebnis manuell. Quellfeld guideline_enter_result.'),
aufgedeckte_fehler_anz INTEGER
OPTIONS(description='Anzahl n.i.O. / aufgedeckter Fehler. Quellfeld guideline_count_errors.'),
feststellungen_anz INTEGER OPTIONS(description='Anzahl der Feststellungen. Quellfeld cnt_issues.'),
massnahmen_anz INTEGER OPTIONS(description='Anzahl der Massnahmen. Quellfeld cnt_actions.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (amx_system_id, frage_id) NOT ENFORCED
)
OPTIONS(description='KMR - This table contains details on the questions / guidelines (frage_id) that are being audited for an activity (kapitel_id). The frage_id is linked to the kapitel_id (activity) and in consequence to the hierarchy_2 of the\"Prüfprogramm\". Does not contain\"Kurzchecks\". Source view v_dwh_kl_data_guideline.');