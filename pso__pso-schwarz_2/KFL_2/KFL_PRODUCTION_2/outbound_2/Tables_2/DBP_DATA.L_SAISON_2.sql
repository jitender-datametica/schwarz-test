--==============================================================
-- Table: l_saison_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_saison_2
   generated from Powerdesigner on Montag, 14. März 2022 11:18:08
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_saison_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
saison_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Saison aus saiso, z.Bsp 9'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='AIS_KMO - Lookuptabelle der Saisonkennzeichen aus der SAP Tabelle T6WSP_2');