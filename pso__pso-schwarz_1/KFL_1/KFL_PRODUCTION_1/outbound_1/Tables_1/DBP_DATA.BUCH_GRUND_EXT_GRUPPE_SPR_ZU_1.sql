--==============================================================
-- Table: buch_grund_ext_gruppe_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: buch_grund_ext_gruppe_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.buch_grund_ext_gruppe_spr_zu_1 (
system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;'),
buch_grund_ext_gruppe_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Gruppierungsmerkmal über externe Buchungsgründe'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.'),
buch_grund_ext_gruppe_bez STRING(40) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung der Gruppierung über externe Buchungsgründe'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (system_id, mandant_id, buch_grund_ext_gruppe_id) NOT ENFORCED
)
OPTIONS(description='RPW - DATA - Sprachtabhängige Bezeichnungen für die Gruppierung des externen Buchungsgrundes             ');