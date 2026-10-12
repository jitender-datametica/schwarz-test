CREATE OR REPLACE TABLE kfl_production_dbp_data.projektphase_status_spr_zu (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
projektphase_status_id INTEGER NOT NULL OPTIONS(description='ID des Status der Projektphase.'),
projektphase_status_bez STRING(200) NOT NULL
OPTIONS(description='Sprachabhängige Bezeichnung des Status der Projektphase'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id, projektphase_status_id) NOT ENFORCED
) OPTIONS(description='Tabelle für sprachabhängige Bezeichnungen der Status der Projektphasen.');