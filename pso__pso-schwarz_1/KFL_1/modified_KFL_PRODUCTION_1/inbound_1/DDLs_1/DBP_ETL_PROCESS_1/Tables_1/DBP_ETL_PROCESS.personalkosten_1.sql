CREATE OR REPLACE TABLE PERSONALKOSTEN_1 (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_1 im DWH',
	WUP_ID INTEGER NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID INTEGER NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	KJMO INTEGER NOT NULL COMMENT 'Kalenderjahresmonat',
	KOSTEN_IST NUMBER(29,4) NOT NULL,
	ABGR_FG INTEGER NOT NULL,
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
);