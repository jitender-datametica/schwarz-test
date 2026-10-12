--==============================================================
-- Table: sok_kategorie_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: sok_kategorie_spr_zu
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 11:55:15
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.sok_kategorie_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
sok_kategorie_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der SOK Kategorie. Fasst mehrere primäre Platzierungswarengruppen zu einer übergeordneten Berichtshierarchie-Ebene zusammen.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache.'),
sok_kategorie_bez STRING(100) OPTIONS(description='Bezeichnung der SOK Kategorie.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, sok_kategorie_id, spr_id) NOT ENFORCED
) OPTIONS(description='Bezeichnungen der SOK Kategorie in unterschiedlichen Sprachen.');