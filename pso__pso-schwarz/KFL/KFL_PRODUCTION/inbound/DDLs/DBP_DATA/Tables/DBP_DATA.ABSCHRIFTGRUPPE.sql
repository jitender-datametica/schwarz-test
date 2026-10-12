create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ABSCHRIFTGRUPPE (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	ABSCHRIFTGRUPPE_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Abschriftgruppe. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden. Zwischen den Gruppen gibt es eine Hierarchie mit mehreren Ebenen.',
	ABSCHRIFTGRUPPE_EBENE_KZ VARCHAR(100) NOT NULL COMMENT 'Kennzeichen der Ebene innerhalb der Abschriftgruppen-Hierarchie.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ABSCHRIFTGRUPPE primary key (MANDANT_ID, ABSCHRIFTGRUPPE_ID)
)COMMENT='Tabelle beinhaltet Abschriftgruppen jeglicher Hierarchie-Ebenen. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden. Zwischen den Gruppen gibt es eine Hierarchie mit mehreren Ebenen.'
;
