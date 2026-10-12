CREATE OR REPLACE TABLE PERSONALSTD_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Marktnummer',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Nummer des Nebenbetriebs',
	KJMO NUMBER(38,0) NOT NULL COMMENT 'Kalenderjahresmonat',
	STUNDEN_IST NUMBER(9,2) NOT NULL COMMENT 'Iststunden',
	STUNDEN_PLAN NUMBER(38,0) NOT NULL COMMENT 'Planstunden als genzzahliger Wert',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
);