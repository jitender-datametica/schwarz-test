CREATE TABLE DBP_DATA.MDL_FEEDBACK_2 (
	FEEDBACK_ID VARCHAR(300) NOT NULL COMMENT 'Feedback ID aus Medallia',
	FRAGE_ID INTEGER NOT NULL COMMENT 'Frage ID aus Medallia',
	ANTWORT_ID INTEGER NOT NULL COMMENT 'Antwort ID aus Medallia',
	DAT_FEEDBACK DATE NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'Datum an dem das Feedback gesendet wurde',
	DAT_EINKAUF DATE NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'Datum, zu dem der Kunde einkaufen war/Datum des Einkaufs',
	ZEITSPANNE_EINKAUF_ID INTEGER NOT NULL DEFAULT -1 COMMENT 'ID der Zeitspanne/Einkaufszeit',
	MANDANT_ID INTEGER NOT NULL DEFAULT -1 COMMENT 'Mandant_2 im DWH',
	GF_ID INTEGER NOT NULL DEFAULT -1 COMMENT 'Geschäftsführer ID, numerisch',
	WUP_ID INTEGER NOT NULL DEFAULT 0 COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID INTEGER NOT NULL DEFAULT -1 COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	DE_WUP_LOAD_FG INTEGER NOT NULL DEFAULT 0 COMMENT 'Kennzeichnet deutsche Hauptfragen die zusätzlich auf Filial-Ebene geladen werden',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='KMR - Medallia - Zentrale Faktentabelle Kunden-Feedback'
;