CREATE OR REPLACE TABLE kfl_production_dbp_data.l_preis_aenderung_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
preis_aend_grund_id INTEGER NOT NULL OPTIONS(description='ID des Preisänderungsgrunds, z-Bsp. 12'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
abschriftgruppe_id INTEGER
OPTIONS(description='ID der Abschriftgruppe. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden. Zwischen den Gruppen gibt es eine_2 Hierarchie mit mehreren Ebenen.'),
PRIMARY KEY (mandant_id, preis_aend_grund_id) NOT ENFORCED
) OPTIONS(description='WWC - Lookup-Tabelle der Preisänderungsgründe aus der Quelle TWBNT');