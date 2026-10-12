CREATE OR REPLACE TABLE kfl_production_dbp_data.flw_pruef_los_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH. In der Regel länderbezogen'),
prueflos_id INTEGER NOT NULL OPTIONS(description='Eindeutige Prüflosnummer aus prueflos'),
best_beleg_id INTEGER NOT NULL OPTIONS(description='Belegnummer des Einkaufsbelegs aus ebeln'),
best_beleg_pos_id INTEGER NOT NULL OPTIONS(description='Belegposition des Einkaufsbelegs aus ebelp'),
werk_id INTEGER NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
flw_art_id INTEGER NOT NULL OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
herkunft INTEGER NOT NULL
OPTIONS(description='Stelle im Produktionsprozess, an der das Prüflos entnommen wurde aus herkunft. Keine Lookup-Tabelle vorhanden'),
flw_lief_id INTEGER NOT NULL OPTIONS(description='Lieferantennummer. Im DWH erzeugter numerischer Schlüssel'),
pruefart_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Die Prüfart ist z.Bsp 01 = Eingangsprüfung beim WE zur Bestellung aus art_1'),
system_id INTEGER NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, prueflos_id) NOT ENFORCED
) OPTIONS(description='FLW - Prüflossatz aus der Quelltabelle qals');