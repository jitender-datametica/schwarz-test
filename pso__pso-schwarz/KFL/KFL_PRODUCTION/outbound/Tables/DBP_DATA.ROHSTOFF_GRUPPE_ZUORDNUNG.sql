--==============================================================
-- Table: rohstoff_gruppe_zuordnung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: rohstoff_gruppe_zuordnung
   generated from Powerdesigner on Mittwoch, 1. Oktober 2025 11:01:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rohstoff_gruppe_zuordnung (
rohstoff_gruppe_typ_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Gruppierungstyps eines Rohstoffs.'),
rohstoff_gruppe_name STRING(100) NOT NULL OPTIONS(description='Name der Gruppe eines Rohstoffs nach Gruppierungstyp.'),
zugeordnete_rohstoff_gruppe_typ_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der zugeordnete Rohstoffgruppe.'),
zugeordnete_rohstoff_gruppe_name STRING(100) NOT NULL OPTIONS(description='Name der zugeordneten Rohstoffsgruppe.'),
rohstoff_gruppe_zuordnungstyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der Zurodnungstyp zwischen Rohstoffgruppen.'),
dat_gueltig_von DATE
OPTIONS(description='Gibt an, ab welchem Datum die Zuordnung zwischen den Rohstoffengruppen in die Rohstoffberichte gültig ist.'),
dat_gueltig_bis DATE
OPTIONS(description='Gibt an, bis zu welchem Datum die Zuordnung zwischen den Rohstoffengruppen in die Rohstoffberichte gültig ist.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (rohstoff_gruppe_typ_id, rohstoff_gruppe_name, rohstoff_gruppe_zuordnungstyp_id,
 zugeordnete_rohstoff_gruppe_typ_id, zugeordnete_rohstoff_gruppe_name) NOT ENFORCED
) OPTIONS(description='Zuordnungstabelle zwischen Rohstoffsgruppen.');