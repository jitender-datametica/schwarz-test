--==============================================================
-- Table: belegklasse_gruppe_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belegklasse_gruppe_spr_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.belegklasse_gruppe_spr_zu (
belegklasse_gruppe_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Belegklasse - Gruppe'),
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;'),
system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.'),
belegklasse_gruppe_bez STRING(40) COLLATE 'und:ci'
OPTIONS(description='sprachabhaengige Bezeichnung fuer die Belegklasse -Gruppe.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (belegklasse_gruppe_id, mandant_id, system_id, spr_id) NOT ENFORCED
) OPTIONS(description='Sprachabhängige Bezeichnung der Belegklassen Gruppierung');