CREATE OR REPLACE TABLE kfl_production_dbp_data.immo_gebiet_spr_zu_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
gebiet_id INTEGER NOT NULL OPTIONS(description='Gebiet ID'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
gebiet_bez STRING(30) COLLATE 'und:ci' DEFAULT ' ' NOT NULL OPTIONS(description='Bezeichnung Gebiet '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, gebiet_id, spr_id) NOT ENFORCED
) OPTIONS(description='IMMO - Sprachabhängige Tabelle für Gebiete - SAP REFX - ZTB0000VZOP9OT');