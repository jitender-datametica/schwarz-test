create or replace TABLE KFL_PRODUCTION.DBP_DATA.L_ABSCHRIFTART (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	ABSCHRIFTART_ID NUMBER(38,0) NOT NULL COMMENT 'Abschriftenart  -  numerisch',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	ABSCHRIFTGRUPPE_ID NUMBER(38,0) COMMENT 'ID der Abschriftgruppe. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden. Zwischen den Gruppen gibt es eine Hierarchie mit mehreren Ebenen.',
	constraint PK_L_ABSCHRIFTART primary key (MANDANT_ID, ABSCHRIFTART_ID)
)COMMENT='TP2_AIS - Lookup Tabelle der Abschriftenschlüssel'
;