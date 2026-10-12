create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.L_LAGER_BEWART_2 (
	LAGER_BEWART_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Schlüssel der Bewegungsarten der Lagerbewegung.',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	SYSTEM_ID NUMBER(38,0) NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	ABSCHRIFTGRUPPE_ID NUMBER(38,0) COMMENT 'ID der Abschriftgruppe. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden. Zwischen den Gruppen gibt es eine_2 Hierarchie mit mehreren Ebenen.',
	constraint PK_L_LAGER_BEWART primary key (LAGER_BEWART_ID, MANDANT_ID)
)COMMENT='TP408 LVS - In dieser Tabelle sind die Bewegungsarten innerhalb des Lagers aus der SAP Quelle T156T enthalten'
;
