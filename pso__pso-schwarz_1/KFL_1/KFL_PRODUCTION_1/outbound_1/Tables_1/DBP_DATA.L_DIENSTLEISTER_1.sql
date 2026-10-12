--==============================================================
-- Table: l_dienstleister_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_dienstleister_1
   generated from Powerdesigner on Mittwoch, 17. Mai 2023 12:02:18
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_dienstleister_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
dienstleister_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Dienstleister, der bei online bestellten Waren beauftragt wird.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, dienstleister_id) NOT ENFORCED
)
OPTIONS(description='Lookuptabelle zur dienstleister ID. Beinhaltet Dienstleister die bei online bestellten Waren beauftragt werden.             Beladung erfolg manuell über CSV Datei.');