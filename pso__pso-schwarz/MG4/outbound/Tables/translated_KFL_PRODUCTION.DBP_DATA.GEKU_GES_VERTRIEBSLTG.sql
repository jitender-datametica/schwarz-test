CREATE OR REPLACE TABLE kfl_production_dbp_data.geku_ges_vertriebsltg (
country_uid INTEGER NOT NULL OPTIONS(description='Eindeutige ID des Landes aus country_nr'),
land_iso STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='ISO - Kürzel des Landes (z.Bsp. DE)'),
land_bez STRING(60) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Landes'),
verteiltag_id INTEGER OPTIONS(description='Entspricht der wtag_id des Datenmodells. Von 1 bis 7, wobei Montag = 1'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (country_uid) NOT ENFORCED
) OPTIONS(description='GEKU - Lookup Tabelle der Gesamtvertriebsleitung');