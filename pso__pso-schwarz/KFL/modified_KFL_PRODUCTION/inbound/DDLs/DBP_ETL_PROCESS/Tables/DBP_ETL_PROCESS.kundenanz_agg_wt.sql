CREATE OR REPLACE TABLE KUNDENANZ_AGG_WT (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant im DWH',
	WUP_ID INTEGER NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID INTEGER NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	DAT DATE,
	CALC_FG INTEGER,
	DAT_LIEF DATE,
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
);