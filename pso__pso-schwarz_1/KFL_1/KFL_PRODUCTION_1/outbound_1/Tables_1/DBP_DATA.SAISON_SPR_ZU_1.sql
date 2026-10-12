--==============================================================
-- Table: saison_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: saison_spr_zu_1
   generated from Powerdesigner on Montag, 14. März 2022 11:26:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.saison_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
saison_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Saison aus saiso, z.Bsp 9'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
saison_bez STRING(30) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Saisonkennzeichens, z.Bsp Sommer'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='AIS_KMO - Sprachabhängige Bezeichnungen der Saison');