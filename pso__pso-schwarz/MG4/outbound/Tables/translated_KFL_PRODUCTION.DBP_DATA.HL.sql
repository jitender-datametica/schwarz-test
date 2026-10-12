CREATE OR REPLACE TABLE kfl_production_dbp_data.hl (
hl_id INTEGER NOT NULL OPTIONS(description='Hausleiter ID entspricht der Mitarbeiter ID\n            '),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
hl_name STRING(40) COLLATE 'und:ci'
OPTIONS(description='Name des Hausleiters, i.d.R. bestehend aus Anrede, Vor- und Zuname (Herr Hans Mustermann)'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (hl_id, mandant_id) NOT ENFORCED
) OPTIONS(description='VIS - Lookup Tabelle der Hausleiter');