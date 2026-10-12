CREATE OR REPLACE TABLE kfl_production_dbp_data.l_lager_bewart_2 (
lager_bewart_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Schlüssel der Bewegungsarten der Lagerbewegung.'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
system_id INTEGER NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
abschriftgruppe_id INTEGER
OPTIONS(description='ID der Abschriftgruppe. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden. Zwischen den Gruppen gibt es eine_2 Hierarchie mit mehreren Ebenen.'),
PRIMARY KEY (mandant_id) NOT ENFORCED
)
OPTIONS(description='TP408 LVS - In dieser Tabelle sind die Bewegungsarten innerhalb des Lagers aus der SAP Quelle T156T enthalten');