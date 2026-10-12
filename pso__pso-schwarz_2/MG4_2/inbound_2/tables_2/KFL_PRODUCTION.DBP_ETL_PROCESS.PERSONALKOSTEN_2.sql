create or replace TABLE KFL_PRODUCTION.DBP_ETL_PROCESS.PERSONALKOSTEN_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	KJMO NUMBER(38,0) NOT NULL COMMENT 'Kalenderjahresmonat',
	KOSTEN_IST NUMBER(18,4) NOT NULL,
	ABGR_FG NUMBER(38,0) NOT NULL,
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
);