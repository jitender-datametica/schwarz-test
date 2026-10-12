create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.PROJEKTART_SPR_ZU_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	PROJEKTART_CD VARCHAR(20) NOT NULL COMMENT 'Eindeutiger alphanumerischer Code der Projektart',
	PROJEKTART_BEZ VARCHAR(200) NOT NULL COMMENT 'Sprachabhängige Bezeichnung der Projektart.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_PROJEKTART_SPR_ZU primary key (MANDANT_ID, SPR_ID, PROJEKTART_CD)
)COMMENT='Tabelle für sprachabhängige Bezeichnungen der Projektarten.'
;
