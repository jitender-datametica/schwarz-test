--==============================================================
-- Table: crm_optin_kanal_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_optin_kanal_spr_zu_1
   generated from Powerdesigner on Montag, 15. September 2025 15:27:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_optin_kanal_spr_zu_1 (
crm_optin_kanal_cd STRING(50) NOT NULL OPTIONS(description='CRM-interne Code für den Kanal des Optins.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
crm_optin_kanal_bez STRING(200) OPTIONS(description='Bezeichnug für den Kanal des Optins.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_optin_kanal_cd, spr_id) NOT ENFORCED
) OPTIONS(description='CRM - Sprachtabelle fuer die Opt-In Kanäle aus Cosmos DB CRM.');