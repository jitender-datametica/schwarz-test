CREATE OR REPLACE TABLE kfl_production_dbp_data.projekt_status_spr_zu_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
projekt_status_id INTEGER NOT NULL OPTIONS(description='ID des Projektstatus.'),
projekt_status_bez STRING(200) NOT NULL OPTIONS(description='Sprachabhängige Bezeichnung des Projektstatus.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, projekt_status_id, spr_id) NOT ENFORCED
) OPTIONS(description='Tabelle für sprachabhängige Bezeichnungen der Projektstatus.');