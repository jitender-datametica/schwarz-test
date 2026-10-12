--==============================================================
-- Table: rohstoff_gruppe
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: rohstoff_gruppe
   generated from Powerdesigner on Donnerstag, 22. Mai 2025 09:53:25
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rohstoff_gruppe (
rohstoff_gruppe_typ_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Gruppierungstyps eines Rohstoffs.'),
rohstoff_gruppe_name STRING(100) NOT NULL OPTIONS(description='Name der Gruppe eines Rohstoffs nach Gruppierungstyp.'),
rohstoff_gruppe_kurz_name STRING(100) OPTIONS(description='Abkürzung der Rohstoffsgruppe name.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (rohstoff_gruppe_typ_id, rohstoff_gruppe_name) NOT ENFORCED
) OPTIONS(description='Gruppe eines Rohstoffs nach Gruppierungstyp.');