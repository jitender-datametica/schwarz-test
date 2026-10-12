CREATE OR REPLACE TABLE PERSONALSTD_2 (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_2 im DWH',
	WUP_ID INTEGER NOT NULL COMMENT 'Marktnummer',
	NB_ID INTEGER NOT NULL COMMENT 'Nummer des Nebenbetriebs',
	KJMO INTEGER NOT NULL COMMENT 'Kalenderjahresmonat',
	STUNDEN_IST NUMBER(29,2) NOT NULL COMMENT 'Iststunden',
	STUNDEN_PLAN INTEGER NOT NULL COMMENT 'Planstunden als genzzahliger Wert',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
);