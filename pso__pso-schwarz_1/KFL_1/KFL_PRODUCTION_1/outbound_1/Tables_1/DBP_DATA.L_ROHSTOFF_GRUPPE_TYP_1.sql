--==============================================================
-- Table: l_rohstoff_gruppe_typ_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_rohstoff_gruppe_typ_1
   generated from Powerdesigner on Donnerstag, 22. Mai 2025 09:53:25
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_rohstoff_gruppe_typ_1 (
rohstoff_gruppe_typ_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Gruppierungstyps eines Rohstoffs.'),
rohstoff_gruppe_typ_bez STRING(200) NOT NULL OPTIONS(description='Bezeichnung des Gruppierungstyps eines Rohstoffs.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (rohstoff_gruppe_typ_id) NOT ENFORCED
)
OPTIONS(description='Lookup Tabelle für Gruppierungstyp eines Rohstoffs - KFL Kategorie, KFL Subkategorie, MINTEC Kategorie, MINTEC Subkategorie');