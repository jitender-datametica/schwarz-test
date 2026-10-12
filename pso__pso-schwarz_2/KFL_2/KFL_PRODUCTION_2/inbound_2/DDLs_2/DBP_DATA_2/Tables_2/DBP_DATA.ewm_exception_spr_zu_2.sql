CREATE TABLE DBP_DATA.EWM_EXCEPTION_SPR_ZU_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	LAGERNUMMER_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'ID der Lagernummer - höchste Ebene der Lagerhierarchie',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	EWM_EXCEPTION_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'Ausnahme_2-Code     ',
	EWM_EXCEPTION_BEZ VARCHAR(40) COLLATE 'en-ci' COMMENT 'Bezeichnung von Ausnahme_2',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
);