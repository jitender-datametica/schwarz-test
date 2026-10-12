create or replace TABLE KFL_PRODUCTION.DBP_DATA.CPR_AUFGABE_SPR_ZU_PER (
	CPR_AUFGABE_ID VARCHAR(32) NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige ID der Aufgabe aus xlctask',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'Referenz zu der Tabelle spr fuer jede DWH Sprache = 1.',
	DAT_VON DATE NOT NULL COMMENT 'Datum, ab dem der Datensatz gültig ist',
	DAT_BIS DATE NOT NULL COMMENT 'Datum, bis zu dem der Datensatz gültig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.',
	AUFGABE_BEZ VARCHAR(40) COLLATE 'en-ci' COMMENT 'Sprachabhängige Bezeichnung der Aufgabe aus txtmd',
	AUFGABE_LANGTEXT VARCHAR(320) COLLATE 'en-ci' COMMENT 'Sprachabhängiger Langtext einer Aufgabe',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CPR_AUFGABE_SPR_ZU_PER primary key (CPR_AUFGABE_ID, SPR_ID, DAT_VON)
)COMMENT='IOS - Bezeichnung der Aufgabe'
;