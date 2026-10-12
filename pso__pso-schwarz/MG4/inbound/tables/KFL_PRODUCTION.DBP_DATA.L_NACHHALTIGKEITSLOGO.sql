create or replace TABLE KFL_PRODUCTION.DBP_DATA.L_NACHHALTIGKEITSLOGO (
	NACHHALTIGKEITSLOGO_ID NUMBER(38,0) NOT NULL COMMENT 'Id des Nachhaltigkeitslogos (bspw. Blauer Engel)',
	NACHHALTIGKEITSLOGO_BEZ VARCHAR(50) NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung des Nachhaltigkeitslogos (bspw. Blauer Engel)',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	LOGO_KZSTG VARCHAR(3) NOT NULL DEFAULT '' COMMENT 'Nachhaltigkeitslogo SAP',
	constraint PK_L_NACHHALTIGKEITSLOGO primary key (NACHHALTIGKEITSLOGO_ID, LOGO_KZSTG)
)COMMENT='AIS - Lookup für Nachhaltigkeitslogos. Initialbeladung durch DWH.'
;