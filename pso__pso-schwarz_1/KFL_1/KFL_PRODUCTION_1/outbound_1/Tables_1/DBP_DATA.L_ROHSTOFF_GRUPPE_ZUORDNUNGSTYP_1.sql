--==============================================================
-- Table: l_rohstoff_gruppe_zuordnungstyp_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_rohstoff_gruppe_zuordnungstyp_1
   generated from Powerdesigner on Mittwoch, 1. Oktober 2025 10:58:42
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_rohstoff_gruppe_zuordnungstyp_1 (
rohstoff_gruppe_zuordnungstyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der Zurodnungstyp zwischen Rohstoffgruppen.'),
rohstoff_gruppe_zuordnungstyp_bez STRING(200) NOT NULL
OPTIONS(description='Bezeichnung des Zuordnungstyps zwischen Rohstoffgruppen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (rohstoff_gruppe_zuordnungstyp_id) NOT ENFORCED
)
OPTIONS(description='Lookup Tabelle für Zurodnungstyp zwischen Rohstoffgruppen.(ZB: Zuordnung zwischen KFL Kategorie und KFL Subkategorie..)');