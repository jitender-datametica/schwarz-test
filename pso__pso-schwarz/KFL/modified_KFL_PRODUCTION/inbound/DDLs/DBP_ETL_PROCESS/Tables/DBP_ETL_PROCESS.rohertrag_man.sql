CREATE OR REPLACE TABLE ROHERTRAG_MAN (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant im DWH',
	WUP_ID INTEGER NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID INTEGER NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	KJMO INTEGER NOT NULL COMMENT 'Kalenderjahresmonat',
	ROHERTRAG_IST NUMBER(29,4) NOT NULL,
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
);