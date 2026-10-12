CREATE OR REPLACE TABLE kfl_production_dbp_data.monat_spr_zu (
mo_id INTEGER NOT NULL OPTIONS(description='Nummer des Monats (zwischen 1 und 12)'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
mo_bez STRING(20) COLLATE 'und:ci' OPTIONS(description='Bezeichnung eines Kalendermonats'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mo_id, spr_id) NOT ENFORCED
) OPTIONS(description='Bezeichnung der Monate in den DWH-Sprachen');