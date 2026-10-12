create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.PSP_STATUS_SPR_ZU_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache.',
	PSP_STATUS_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Status_1 der PSP_NR / des Buchungselementes.',
	PSP_STATUS_BEZ VARCHAR(200) NOT NULL COMMENT 'Sprachabhängige Bezeichnung des PSP Status.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_PSP_STATUS_SPR_ZU primary key (MANDANT_ID, PSP_STATUS_ID, SPR_ID)
)COMMENT='Tabelle für sprachabhängige Bezeichnungen des Status_1 der PSP_NR / des Buchungselementes.'
;
