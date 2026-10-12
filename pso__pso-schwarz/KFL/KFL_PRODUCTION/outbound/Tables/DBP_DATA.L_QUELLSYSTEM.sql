--==============================================================
-- Table: l_quellsystem
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_quellsystem
   generated from Powerdesigner on Dienstag, 9. Januar 2024 11:59:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_quellsystem (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
quellsystem_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Quellsystems.'),
quellsystem_bez STRING(100) OPTIONS(description='Bezeichnung des Quellsystems.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, quellsystem_id) NOT ENFORCED
) OPTIONS(description='Beinhaltet die IDs der Quellsysteme.');