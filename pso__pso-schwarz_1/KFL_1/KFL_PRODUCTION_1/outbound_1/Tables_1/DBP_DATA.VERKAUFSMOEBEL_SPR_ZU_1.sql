--==============================================================
-- Table: verkaufsmoebel_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: verkaufsmoebel_spr_zu_1
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 14:55:56
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.verkaufsmoebel_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
verkaufsmoebel_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Verkaufsmöbels - Ein Verkaufsmöbel ist der Gegenstand auf / in dem die Artikel_1 in der Filiale verkauft werden.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
verkaufsmoebel_bez STRING(100) OPTIONS(description='Bezeichnung des Verkaufsmöbels.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, verkaufsmoebel_id, spr_id) NOT ENFORCED
) OPTIONS(description='Bezeichnungen der Verkaufsmöbel in unterschiedlichen Sprachen.');