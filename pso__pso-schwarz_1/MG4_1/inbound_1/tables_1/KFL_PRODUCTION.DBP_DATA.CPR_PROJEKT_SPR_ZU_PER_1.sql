create or replace TABLE KFL_PRODUCTION.DBP_DATA.CPR_PROJEKT_SPR_ZU_PER_1 (
	PROJEKT_ID VARCHAR(32) NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige ID des Projekts',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'Referenz zu der Tabelle spr_1 fuer jede DWH Sprache = 1.',
	DAT_VON DATE NOT NULL COMMENT 'Datum, ab dem der Datensatz gültig ist',
	DAT_BIS DATE NOT NULL COMMENT 'Datum, bis zu dem der Datensatz gültig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.',
	CPR_PROJEKT_BEZ VARCHAR(40) NOT NULL COLLATE 'en-ci' COMMENT 'Sprachabhängige Projektbeschreibung',
	CPR_PROJEKT_LANGTEXT VARCHAR(320) COLLATE 'en-ci' COMMENT 'Sprachabhängiger Langtext zum Projekt',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_CPR_PROJEKT_SPR_ZU_PER primary key (PROJEKT_ID, SPR_ID, DAT_VON)
)COMMENT='IOS - Sprachabhängige  Projektbezeichnung'
;