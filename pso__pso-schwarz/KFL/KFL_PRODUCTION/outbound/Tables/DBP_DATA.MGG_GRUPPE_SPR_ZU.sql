--==============================================================
-- Table: mgg_gruppe_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: mgg_gruppe_spr_zu
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 14:32:17
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mgg_gruppe_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
mgg_gruppe_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der MGG (Mengengerüst) Gruppierung. Fasst mehrere Platzierungswarengruppen zu einer übergeordneten Flächenhierarchie-Ebene zusammen.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache.'),
mgg_gruppe_bez STRING(100) OPTIONS(description='Bezeichnung der MGG Gruppe.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, mgg_gruppe_id, spr_id) NOT ENFORCED
) OPTIONS(description='Bezeichnungen der MGG Gruppe in unterschiedlichen Sprachen.');