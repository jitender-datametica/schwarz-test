CREATE TABLE DBP_DATA.EWM_EXCEPTION_SPR_ZU (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant im DWH',
	LAGERNUMMER_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'ID der Lagernummer - höchste Ebene der Lagerhierarchie',
	SPR_ID INTEGER NOT NULL COMMENT 'ID der Sprache',
	EWM_EXCEPTION_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'Ausnahme-Code     ',
	EWM_EXCEPTION_BEZ VARCHAR(40) COLLATE 'en-ci' COMMENT 'Bezeichnung von Ausnahme',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
);