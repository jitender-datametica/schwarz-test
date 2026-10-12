create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.AKTION_TYP_LISTE_SPR_ZU (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	AKTION_TYP_LISTE_ID VARCHAR(500) NOT NULL COMMENT 'Enthält als kommaseparierte Textliste den Typ der Aktion(en) als ID, die verwendet wurde(n).',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	AKTION_TYP_LISTE_BEZ VARCHAR(500) COMMENT 'Enthält als kommaseparierte Textliste die Bezeichnung der Aktionstype(n).',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_AKTION_TYP_LISTE_SPR_ZU primary key (MANDANT_ID, AKTION_TYP_LISTE_ID, SPR_ID)
)COMMENT='AIS - Sprachabhängige Bezeichnungen der Aktionstypen.'
;
