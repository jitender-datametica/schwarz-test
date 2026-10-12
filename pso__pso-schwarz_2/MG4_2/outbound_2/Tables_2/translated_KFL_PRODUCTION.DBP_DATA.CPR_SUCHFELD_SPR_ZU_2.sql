CREATE OR REPLACE TABLE kfl_production_dbp_data.cpr_suchfeld_spr_zu_2 (
spr_id INTEGER NOT NULL OPTIONS(description='Referenz zu der Tabelle spr_2 fuer jede DWH Sprache = 1.'),
cpr_suchfeld_id INTEGER NOT NULL
OPTIONS(description='Diese ID wird bei der Versorgung aus dem von der Quelle gelieferten Feld generiert'),
suchfeld_bez STRING(60) COLLATE 'und:ci' OPTIONS(description='zusätzliche Bezeichnung'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (spr_id, cpr_suchfeld_id) NOT ENFORCED
) OPTIONS(description='IOS - sprachabhängige Bezeichnungen für das C-Projects Suchfeld');