create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.PROJEKTTERMIN_SPR_ZU_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	PROJEKTTERMIN_CD VARCHAR(100) NOT NULL COMMENT 'Code des Projekttermins.',
	PROJEKTTERMIN_BEZ VARCHAR(200) NOT NULL COMMENT 'Sprachabhängige Bezeichnung des Projekttermins.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_PROJEKTTERMIN_SPR_ZU primary key (MANDANT_ID, SPR_ID, PROJEKTTERMIN_CD)
)COMMENT='Tabelle für sprachabhängige Bezeichnungen der Projekttermine.'
;
