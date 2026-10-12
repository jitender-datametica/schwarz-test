CREATE OR REPLACE TABLE kfl_production_dbp_data.art_kreistyp_gruppe_zu_per (
art_id INTEGER NOT NULL OPTIONS(description='Artikel - Id'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
kreistyp_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kreistyp'),
dat_von DATE NOT NULL OPTIONS(description='Beginn der Gültigkeitsperiode'),
kreistyp_gruppe_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Region / Gruppierung Kreistypen'),
dat_bis DATE NOT NULL OPTIONS(description='Endedatum der Gültigkeit, bei aktuellen Sätzen = 31.12.9999'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, mandant_id, dat_von) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Zeitabhängige Zuordnung der Artikel zu Kreistyp und Kreistypgruppe');