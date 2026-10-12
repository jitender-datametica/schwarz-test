CREATE OR REPLACE TABLE kfl_production_dbp_data.artkz_posten (
posten_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige Kennzeichnung des Postenartikels, z.Bsp. PN'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache.'),
posten_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Sprachabhaengige Bezeichnung des Postenkennzeichens.'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Lookuptabelle fuer das Artikelkennzeichen Postenartikel');