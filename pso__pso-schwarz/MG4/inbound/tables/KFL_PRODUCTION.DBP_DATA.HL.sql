create or replace TABLE KFL_PRODUCTION.DBP_DATA.HL (
	HL_ID NUMBER(38,0) NOT NULL COMMENT 'Hausleiter ID entspricht der Mitarbeiter ID\n            ',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	HL_NAME VARCHAR(40) COLLATE 'en-ci' COMMENT 'Name des Hausleiters, i.d.R. bestehend aus Anrede, Vor- und Zuname (Herr Hans Mustermann)',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_HL primary key (HL_ID, MANDANT_ID)
)COMMENT='VIS - Lookup Tabelle der Hausleiter'
;