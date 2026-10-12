CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.L_ABSCHRIFTART_1 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
ABSCHRIFTART_ID INTEGER NOT NULL OPTIONS(description='Abschriftenart  -  numerisch'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
ABSCHRIFTGRUPPE_ID INTEGER
OPTIONS(description='ID der Abschriftgruppe. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden. Zwischen den Gruppen gibt es eine_1 Hierarchie mit mehreren Ebenen.'),
PRIMARY KEY (MANDANT_ID, ABSCHRIFTART_ID) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Lookup Tabelle der Abschriftenschlüssel');