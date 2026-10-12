create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ABSCHRIFTGRUPPE_HIERARCHIE_ZU_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	ABSCHRIFTGRUPPE_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Abschriftgruppe. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden- Zwischen den Gruppen gibt es eine_2 Hierarchie mit mehreren Ebenen.',
	UEBERGEORDNETE_ABSCHRIFTGRUPPE_ID NUMBER(38,0) NOT NULL COMMENT 'ID der übergeordneten Abschriftgruppe_2 in der Hierarchie. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden- Zwischen den Gruppen gibt es eine_2 Hierarchie mit mehreren Ebenen.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ABSCHRIFTGRUPPE_HIERARCHIE_ZU primary key (MANDANT_ID, ABSCHRIFTGRUPPE_ID, UEBERGEORDNETE_ABSCHRIFTGRUPPE_ID)
)COMMENT='Beziehungstabelle zwischen den Abschriftgruppen verschiedener Hierarchieebenen. Eine_2 Abschriftgruppe_2 wird einer in der Hierarchie übergeordneten Abschriftgruppe_2 zugeordnet.'
;
