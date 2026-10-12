CREATE OR REPLACE TABLE kfl_production_dbp_data.l_abschriftart (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
abschriftart_id INTEGER NOT NULL OPTIONS(description='Abschriftenart  -  numerisch'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
abschriftgruppe_id INTEGER
OPTIONS(description='ID der Abschriftgruppe. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden. Zwischen den Gruppen gibt es eine Hierarchie mit mehreren Ebenen.'),
PRIMARY KEY (mandant_id, abschriftart_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Lookup Tabelle der Abschriftenschlüssel');