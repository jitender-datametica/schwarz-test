create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.QA_DEKLARATIONSFEHLER_SPR_ZU (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	QA_DEKLARATIONSFEHLER_ID VARCHAR(3) NOT NULL COMMENT 'ID der QA-Deklarationsfehler (, z. B. 002 = Etikett fehlt)',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	QA_DEKLARATIONSFEHLER_BEZ VARCHAR(50) COMMENT 'Bezeichnung der QA-Deklarationsfehler.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_QA_DEKLARATIONSFEHLER_SPR_ZU primary key (MANDANT_ID, QA_DEKLARATIONSFEHLER_ID, SPR_ID)
)COMMENT='Texte für QA-Deklarationsfehler Codes, z. B. 002 = Etikett fehlt'
;
