--==============================================================
-- Table: crm_l_optin_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_optin_1
   generated from Powerdesigner on Montag, 15. September 2025 15:15:22
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_l_optin_1 (
crm_optin_id STRING(36) NOT NULL OPTIONS(description='CRM-interne ID für ein Optin '),
crm_loyalty_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Sagt ob die Herkunft/ der Uprsung ist die Loyalty App.'),
crm_optin_kanal_cd STRING(50) NOT NULL OPTIONS(description='CRM-interne Code für den Kanal des Optins.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_optin_id) NOT ENFORCED
) OPTIONS(description='CRM - Enthaelt Optin Daten aus Cosmos DB CRM.');