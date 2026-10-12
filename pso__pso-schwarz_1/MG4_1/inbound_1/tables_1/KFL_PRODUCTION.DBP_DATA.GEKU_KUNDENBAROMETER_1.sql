create or replace TABLE KFL_PRODUCTION.DBP_DATA.GEKU_KUNDENBAROMETER_1 (
	GEKU_TICKET_ID_KUNDENBAROMETER NUMBER(18,0) NOT NULL COMMENT 'Eindeutiger Schlüssel',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	MANDANT_ID_WUP NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	DAT DATE NOT NULL COMMENT 'Datum aus Eingangsdatum',
	NOTE_AUSWAHL NUMBER(38,0) COMMENT 'Ganzzahlige Note für die Auswahl',
	NOTE_FRISCHE NUMBER(38,0) COMMENT 'Ganzzahlige Note für die Frische',
	NOTE_QUALITAET NUMBER(38,0) COMMENT 'Ganzzahlige Note für die Qualität',
	NOTE_BERATUNG NUMBER(38,0) COMMENT 'Ganzzahlige Note für die Beratung',
	NOTE_FREUNDLICHKEIT_ALLG NUMBER(38,0) COMMENT 'Ganzzahlige Note für die Freundlichkeit allgemein',
	NOTE_FREUNDLICHKEIT_THEKE NUMBER(38,0) COMMENT 'Ganzzahlige Note für die Freundlichkeit an der Theke',
	NOTE_FREUNDLICHKEIT_KASSE NUMBER(38,0) COMMENT 'Ganzzahlige Note für die Freundlichkeit an der Kasse',
	NOTE_SCHNELLIGKEIT_KASSE NUMBER(38,0) COMMENT 'Ganzzahlige Note für die Schnelligkeit an der Kasse',
	NOTE_SCHNELLIGKEIT_THEKE NUMBER(38,0) COMMENT 'Ganzzahlige Note für die Schnelligkeit an der Theke',
	NOTE_PREIS NUMBER(38,0) COMMENT 'Ganzzahlige Note für den Preis',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_GEKU_KUNDENBAROMETER primary key (GEKU_TICKET_ID_KUNDENBAROMETER)
)COMMENT='GEKU - Marktbenotungen aus einem Oracle-System'
;