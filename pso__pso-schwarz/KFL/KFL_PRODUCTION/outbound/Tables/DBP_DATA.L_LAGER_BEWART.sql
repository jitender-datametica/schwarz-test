--==============================================================
-- Table: l_lager_bewart
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_lager_bewart
   generated from Powerdesigner on Donnerstag, 4. April 2024 14:29:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_lager_bewart (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
lager_bewart_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Schlüssel der Bewegungsarten der Lagerbewegung.'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
abschriftgruppe_id BIGNUMERIC(38,0)
OPTIONS(description='ID der Abschriftgruppe. Unterschiedliche Lagerbewegungsarten, Abschriftarten und Preisänderungsgründe können zu Abschriftgruppen zusammengefasst werden. Zwischen den Gruppen gibt es eine Hierarchie mit mehreren Ebenen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
)
OPTIONS(description='TP408 LVS - In dieser Tabelle sind die Bewegungsarten innerhalb des Lagers aus der SAP Quelle T156T enthalten');