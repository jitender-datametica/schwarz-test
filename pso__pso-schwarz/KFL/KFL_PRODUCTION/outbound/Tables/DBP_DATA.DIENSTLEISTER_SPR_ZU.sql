--==============================================================
-- Table: dienstleister_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: dienstleister_spr_zu
   generated from Powerdesigner on Mittwoch, 17. Mai 2023 12:03:42
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.dienstleister_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
dienstleister_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Dienstleister, der bei online bestellten Waren beauftragt wird.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
dienstleister_bez STRING(100) NOT NULL OPTIONS(description='Bezeichnung des Dienstleister'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, dienstleister_id, spr_id) NOT ENFORCED
)
OPTIONS(description='Sprachzuordnungstabelle der Dienstleister, die für online bestellte Ware beauftragt werden.             Beladung erfolgt manuell über CSV Datei.');