CREATE OR REPLACE TABLE kfl_production_dbp_data.temperatur_spr_zu_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
temperatur_id STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kennzeichen für den Temperaturbereich, z.Bsp. 3'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
temperatur_bez STRING(200) OPTIONS(description='Bezeichnung für den Temperaturbereich, z.Bsp. Gefrierware'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Sprachabhängige Bezeichnungen der Temperaturkennzeichen');