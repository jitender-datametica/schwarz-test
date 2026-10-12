--==============================================================
-- Table: belegart_gruppe_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belegart_gruppe_spr_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.belegart_gruppe_spr_zu (
system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;'),
belegart_gruppe_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Gruppierung über die Belegarten (fortlaufende Nummer)'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.'),
belegart_gruppe_bez STRING(40) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung der Belegartengruppen (z.Bsp. Rechnungsbeleg, Gutschrift,...)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (system_id, mandant_id, belegart_gruppe_id) NOT ENFORCED
) OPTIONS(description='RPW - DATA - Sprachtabhängige Bezeichnungen für die Gruppierung der Belegart             ');