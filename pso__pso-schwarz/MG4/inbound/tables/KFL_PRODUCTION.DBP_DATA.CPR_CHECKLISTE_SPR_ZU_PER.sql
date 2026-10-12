create or replace TABLE KFL_PRODUCTION.DBP_DATA.CPR_CHECKLISTE_SPR_ZU_PER (
	CPR_CHECKLISTE_ID VARCHAR(32) NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige ID einer Projekt-Checkliste aus xlccheckl',
	DAT_VON DATE NOT NULL COMMENT 'Datum, ab dem der Datensatz gültig ist',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'Referenz zu der Tabelle spr fuer jede DWH Sprache = 1.',
	DAT_BIS DATE NOT NULL COMMENT 'Datum, bis zu dem der Datensatz gültig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.',
	CPR_CHECKLISTE_BEZ VARCHAR(40) NOT NULL COLLATE 'en-ci' COMMENT 'Sprachabhängige Bezeichnung der Checkliste',
	CPR_CHECKLISTE_LANGTEXT VARCHAR(320) COLLATE 'en-ci' COMMENT 'Sprachabhängiger Langtext zur Checkliste',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CPR_CHECKLISTE_SPR_ZU_PER primary key (CPR_CHECKLISTE_ID, DAT_VON, SPR_ID)
)COMMENT='IOS - Sprachabhängige Beschreibung der Checkliste'
;