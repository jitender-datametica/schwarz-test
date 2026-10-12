--==============================================================
-- Table: fipo_l_pruef_modul_option_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_l_pruef_modul_option_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fipo_l_pruef_modul_option_1 (
fipo_pruef_modul_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='eindeutige ID des FIPO-Prüfmoduls aus dem Quellfeld pmo_id'),
fipo_pruef_modul_option_id STRING(255) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung der Option, z_bsp. Einsatzplanung. Aus dem Quellfeld value'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (fipo_pruef_modul_id) NOT ENFORCED
) OPTIONS(description='FIPO - Lookup Tabelle der Prüfmodul-Optionen aus der Quelltabelle pruefmodule_optionen');