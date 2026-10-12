--==============================================================
-- Table: cpr_suchfeld_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cpr_suchfeld_spr_zu_1
   generated from Powerdesigner on Dienstag, 27. Juni 2023 17:54:10
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.cpr_suchfeld_spr_zu_1 (
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Referenz zu der Tabelle spr_1 fuer jede DWH Sprache = 1.'),
cpr_suchfeld_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Diese ID wird bei der Versorgung aus dem von der Quelle gelieferten Feld generiert'),
suchfeld_bez STRING(60) COLLATE 'und:ci' OPTIONS(description='zusätzliche Bezeichnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (spr_id, cpr_suchfeld_id) NOT ENFORCED
) OPTIONS(description='IOS - sprachabhängige Bezeichnungen für das C-Projects Suchfeld');