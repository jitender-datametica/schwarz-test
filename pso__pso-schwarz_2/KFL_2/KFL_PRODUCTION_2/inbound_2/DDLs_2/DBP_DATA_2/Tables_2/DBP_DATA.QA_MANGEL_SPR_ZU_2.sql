create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.QA_MANGEL_SPR_ZU_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	QA_MANGEL_ID VARCHAR(3) NOT NULL COMMENT 'ID des QA-Mangel (z. B. 001 = Frischemangel)',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	QA_MANGEL_BEZ VARCHAR(50) COMMENT 'Bezeichnung des QA-Mangel',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_QA_MANGEL_SPR_ZU primary key (MANDANT_ID, QA_MANGEL_ID, SPR_ID)
)COMMENT='Texte für QA-Mängel Codes, z. B. 001 = Frischemangel'
;
