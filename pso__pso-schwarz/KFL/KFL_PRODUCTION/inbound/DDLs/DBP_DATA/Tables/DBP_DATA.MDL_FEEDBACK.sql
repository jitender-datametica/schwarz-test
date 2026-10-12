create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.MDL_FEEDBACK (
	FEEDBACK_ID VARCHAR(300) NOT NULL COMMENT 'Feedback ID aus Medallia',
	FRAGE_ID NUMBER(38,0) NOT NULL COMMENT 'Frage ID aus Medallia',
	ANTWORT_ID NUMBER(38,0) NOT NULL COMMENT 'Antwort ID aus Medallia',
	DAT_FEEDBACK DATE NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'Datum an dem das Feedback gesendet wurde',
	DAT_EINKAUF DATE NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'Datum, zu dem der Kunde einkaufen war/Datum des Einkaufs',
	ZEITSPANNE_EINKAUF_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'ID der Zeitspanne/Einkaufszeit',
	MANDANT_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Mandant im DWH',
	GF_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Geschäftsführer ID, numerisch',
	WUP_ID NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	DE_WUP_LOAD_FG NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Kennzeichnet deutsche Hauptfragen die zusätzlich auf Filial-Ebene geladen werden',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='KMR - Medallia - Zentrale Faktentabelle Kunden-Feedback'
;
