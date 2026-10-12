create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.L_ABSCHRIFTART_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	ABSCHRIFTART_ID NUMBER(38,0) NOT NULL COMMENT 'Abschriftenart  -  numerisch',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	ABSCHRIFTGRUPPE_ID NUMBER(38,0) COMMENT 'ID der Abschriftgruppe. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden. Zwischen den Gruppen gibt es eine_1 Hierarchie mit mehreren Ebenen.',
	constraint PK_L_ABSCHRIFTART primary key (MANDANT_ID, ABSCHRIFTART_ID)
)COMMENT='TP2_AIS - Lookup Tabelle der Abschriftenschlüssel'
;
