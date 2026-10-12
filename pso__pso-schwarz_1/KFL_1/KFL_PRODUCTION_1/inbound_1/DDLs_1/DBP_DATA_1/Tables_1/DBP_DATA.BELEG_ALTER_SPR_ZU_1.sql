create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.BELEG_ALTER_SPR_ZU_1 (
	SYSTEM_ID NUMBER(38,0) NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'Referenz zu der Tabelle spr_1 fuer jede DWH Sprache = 1.',
	BELEG_ALTER_ID NUMBER(38,0) NOT NULL COMMENT 'Eindeutiger Schlüssel für die verschiedenen Kategorien des Alters eines Belegs.',
	BELEG_ALTER_BEZ VARCHAR(40) COLLATE 'en-ci' COMMENT 'Sprachabhängige Kurzbezeichnung für die Kategorien des Belegalters. Für jede DWH Sprache = 1 wird ein Eintrag angelegt.',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_BELEG_ALTER_SPR_ZU primary key (SYSTEM_ID, MANDANT_ID, SPR_ID, BELEG_ALTER_ID)
)COMMENT='RPW - Diese Tabelle enthält die sprachabhängigen Kurzbezeichnungen für die Kategorien des Belegalters. Für jede DWH Sprache = 1 wird ein Eintrag angelegt.'
;
