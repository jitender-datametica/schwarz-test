create or replace TABLE KFL_PRODUCTION.DBP_DATA.GEKU_ZUFRIEDENHEIT_1 (
	GEKU_TICKET_ID NUMBER(18,0) NOT NULL COMMENT 'Eindeutige ID eines GEKU Tickets aus case_nr',
	GEKU_NOTENVERGABE_DURCH_ID NUMBER(18,0) NOT NULL COMMENT 'ID der Notenvergeber',
	NOTE_PROBLEM_GELOEST NUMBER(38,0) COMMENT 'Note für die Lösung des Problems',
	NOTE_BEARBEITUNGSZEIT NUMBER(38,0) COMMENT 'Note für die Bearbeitungszeit (Schulnote) aus performance_rate',
	NOTE_FREUNDLICHKEIT NUMBER(38,0) COMMENT 'Note für die Freundlichkeit (Schulnote) aus response_rate',
	NOTE_INHALT NUMBER(38,0) COMMENT 'Note für den Inhalt (Schulnote) aus explain_rate',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_GEKU_ZUFRIEDENHEIT primary key (GEKU_TICKET_ID, GEKU_NOTENVERGABE_DURCH_ID)
)COMMENT='GEKU - Zufriedenheitsergebnisse aus satisfaction_out - MULTISET'
;