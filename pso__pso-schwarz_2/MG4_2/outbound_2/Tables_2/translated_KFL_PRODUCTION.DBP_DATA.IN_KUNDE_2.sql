CREATE OR REPLACE TABLE kfl_production_dbp_data.in_kunde_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH. In der Regel länderbezogen'),
in_kunde_id INTEGER NOT NULL OPTIONS(description='Im DWH generierter Surrogate Key für die Kundennummer aus SAP'),
kunde_nr STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kundennummer aus SAP Industrie im Originalformat'),
system_id INTEGER NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
kunde_name STRING(40) COLLATE 'und:ci' OPTIONS(description='Name des Kunden aus name1_gp'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, in_kunde_id) NOT ENFORCED
) OPTIONS(description='BIS - Die Tabelle wird aus kna1_2 versorgt. Die kunde_id wird im Produkt IVS vverwendet');