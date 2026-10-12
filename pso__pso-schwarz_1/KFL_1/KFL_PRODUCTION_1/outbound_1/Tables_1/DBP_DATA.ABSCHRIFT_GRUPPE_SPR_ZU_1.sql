--==============================================================
-- Table: abschrift_gruppe_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abschrift_gruppe_spr_zu_1
   generated from Powerdesigner on Wednesday, January 31, 2024 2:33:01 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.abschrift_gruppe_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
abschriftgruppe_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Merkmal zur Gruppierung der Abschriften_1'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprache ID'),
abschriftgrp_bez STRING(40) COLLATE 'und:ci'
OPTIONS(description='Sprachabhängige Bezeichnung der Abschriftengruppe            '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, abschriftgruppe_id, spr_id) NOT ENFORCED
) OPTIONS(description='VIS - Sprachabhängige Bezeichnung der Abschriftenhierarchien (=gruppen)');