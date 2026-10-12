CREATE OR REPLACE TABLE kfl_production_dbp_data.art_ofentyp_zu_1 (
art_id INTEGER NOT NULL OPTIONS(description='DWH Artikelnummer'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
ofen_typ_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID des Ofentyps aus dem Quellfeld oventype, z.Bsp. A.'),
blech_belegung INTEGER NOT NULL OPTIONS(description='optimale Anzahl des Artikels pro Backblech'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, mandant_id) NOT ENFORCED
)
OPTIONS(description='VIS Backshop - Diese Tabelle ordnet den Artikeln die Ofentypen zu. Quelle ist die SAP-Klassenbibliothek');