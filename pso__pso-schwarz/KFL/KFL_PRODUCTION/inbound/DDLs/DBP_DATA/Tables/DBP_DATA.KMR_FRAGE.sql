create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.KMR_FRAGE (
	AMX_SYSTEM_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'AMX-System-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.',
	FRAGE_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Frage-ID. Quellfeld guideline_id. Eindeutige ID einer überprüften Frage.',
	KAPITEL_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Kapitel-ID. Quellfeld activity_id. Eindeutige ID eines Prüfbereichs.',
	SORT_NR VARCHAR(255) COMMENT 'Fragennummer. Quellfeld guideline_sort_order. Es ist eine Art ID der Frage im Fragenkatalog einer Landes. Wird diese Frage wieder gestellt / überprüft, hat sie die gleiche sort_nr und frage_text aber eine neue guideline_id.',
	FRAGE_TEXT VARCHAR(50000) COMMENT 'Fragetext. Quellfeld guideline_description_text. Der Text beschreibt den tatsächlichen Gegenstand der Frage, oft in deutscher und Landessprache.',
	ANMERKUNG VARCHAR(50000) COMMENT 'Anmerkung zur Frage. Quellfeld guideline_work_description.',
	FRAGE_STATUS_ID NUMBER(38,0) DEFAULT -1 COMMENT 'Status-ID. Quellfeld guideline_state_id.',
	FRAGE_TYP_ID NUMBER(38,0) DEFAULT -1 COMMENT 'Fragetyp-ID. Quellfeld guideline_checklist_logic_id.',
	STICHPROBE_UMFANG NUMBER(38,0) COMMENT 'Stichprobenumfang. Quellfeld guideline_audited_amount.',
	ERGEBNIS_NUM NUMBER(38,0) COMMENT 'Ergebnis numerisch. Quellfeld guideline_numeric_result.',
	ERGEBNIS_TEXT VARCHAR(255) DEFAULT ' ' COMMENT 'Ergebnis textuell. Quellfeld guideline_textual_result.',
	ERGEBNIS_MAN VARCHAR(1000) COMMENT 'Ergebnis manuell. Quellfeld guideline_enter_result.',
	AUFGEDECKTE_FEHLER_ANZ NUMBER(38,0) COMMENT 'Anzahl n.i.O. / aufgedeckter Fehler. Quellfeld guideline_count_errors.',
	FESTSTELLUNGEN_ANZ NUMBER(38,0) COMMENT 'Anzahl der Feststellungen. Quellfeld cnt_issues.',
	MASSNAHMEN_ANZ NUMBER(38,0) COMMENT 'Anzahl der Massnahmen. Quellfeld cnt_actions.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_KMR_FRAGE primary key (AMX_SYSTEM_ID, FRAGE_ID)
)COMMENT='KMR - This table contains details on the questions / guidelines (frage_id) that are being audited for an activity (kapitel_id). The frage_id is linked to the kapitel_id (activity) and in consequence to the hierarchy of the \""Prüfprogramm\"". Does not contain \""Kurzchecks\"". Source view v_dwh_kl_data_guideline.'
;
