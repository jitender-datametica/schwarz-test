CREATE OR REPLACE TABLE kfl_production_dbp_data.projekttermin_spr_zu_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
projekttermin_cd STRING(100) NOT NULL OPTIONS(description='Code des Projekttermins.'),
projekttermin_bez STRING(200) NOT NULL OPTIONS(description='Sprachabhängige Bezeichnung des Projekttermins.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id, projekttermin_cd) NOT ENFORCED
) OPTIONS(description='Tabelle für sprachabhängige Bezeichnungen der Projekttermine.');