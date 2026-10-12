create or replace TABLE KFL_PRODUCTION.DBP_DATA.GEKU_TICKET_TEXT_1 (
	GEKU_TICKET_ID NUMBER(18,0) NOT NULL COMMENT 'Eindeutige ID eines GEKU Tickets aus case_nr',
	TEXTART_ID NUMBER(38,0) NOT NULL COMMENT 'ID für die Art_1 des Textes, z.Bsp. Kommentar, Kommentar übersetzt.',
	TEXT VARCHAR(10000) COLLATE 'en-ci' COMMENT 'zu dem Ticket gehörender Text, z.Bsp. Beschwerde, Antworttext etc.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_GEKU_TICKET_TEXT primary key (GEKU_TICKET_ID, TEXTART_ID)
)COMMENT='GEKU - die Texte zu den Tickets sind in diese separate Tabelle ausgelagert'
;