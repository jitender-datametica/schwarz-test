--==============================================================
-- Table: fipo_kategorie_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_kategorie_spr_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fipo_kategorie_spr_zu (
fipo_kategorie_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige ID einer FIPO-Kategorie aus dem Quellfeld kat_id'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
fipo_kategorie_bez STRING(255) OPTIONS(description='Bezeichnung einer FIPO-Kategorie aus dem Quellfeld kai_kategorie'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (fipo_kategorie_id, spr_id) NOT ENFORCED
) OPTIONS(description='FIPO - Sprachtabelle zu Kategerien - Quelltabelle kategorien_int');