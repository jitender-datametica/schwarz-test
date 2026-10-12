create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.PROJEKTROLLE_SPR_ZU (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	PROJEKTROLLE_CD VARCHAR(100) NOT NULL COMMENT 'Eindeutiger Code der Projektrolle.',
	PROJEKTROLLE_BEZ VARCHAR(200) NOT NULL COMMENT 'Sprachabhängige Bezeichnung der Projektrolle.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_PROJEKTROLLE_SPR_ZU primary key (MANDANT_ID, SPR_ID, PROJEKTROLLE_CD)
)COMMENT='Tabelle für sprachabhängige Bezeichnungen der Projektrollen.'
;
