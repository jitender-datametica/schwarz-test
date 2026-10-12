create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ABSCHRIFTGRUPPE_SPR_ZU_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	ABSCHRIFTGRUPPE_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Abschriftgruppe. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden. Zwischen den Gruppen gibt es eine_1 Hierarchie mit mehreren Ebenen.',
	ABSCHRIFTGRUPPE_BEZ VARCHAR(100) COMMENT 'Sprachabhängige Bezeichnung der Abschriftgruppe.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ABSCHRIFTGRUPPE_SPR_ZU primary key (MANDANT_ID, SPR_ID, ABSCHRIFTGRUPPE_ID)
)COMMENT='Sprachtabelle der Abschriftgruppen.'
;
