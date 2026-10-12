create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.L_PREIS_AENDERUNG (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	PREIS_AEND_GRUND_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Preisänderungsgrunds, z-Bsp. 12',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	ABSCHRIFTGRUPPE_ID NUMBER(38,0) COMMENT 'ID der Abschriftgruppe. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden. Zwischen den Gruppen gibt es eine Hierarchie mit mehreren Ebenen.',
	constraint PK_L_PREIS_AENDERUNG primary key (MANDANT_ID, PREIS_AEND_GRUND_ID)
)COMMENT='WWC - Lookup-Tabelle der Preisänderungsgründe aus der Quelle TWBNT'
;
