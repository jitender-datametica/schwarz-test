CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.L_LAGER_BEWART_2 (
LAGER_BEWART_ID STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Schlüssel der Bewegungsarten der Lagerbewegung.'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
SYSTEM_ID INTEGER NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
ABSCHRIFTGRUPPE_ID INTEGER
OPTIONS(description='ID der Abschriftgruppe. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden. Zwischen den Gruppen gibt es eine_2 Hierarchie mit mehreren Ebenen.'),
PRIMARY KEY (MANDANT_ID) NOT ENFORCED
)
OPTIONS(description='TP408 LVS - In dieser Tabelle sind die Bewegungsarten innerhalb des Lagers aus der SAP Quelle T156T enthalten');