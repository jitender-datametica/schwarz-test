--==============================================================
-- Table: crm_optin_statusgrund_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_optin_statusgrund_spr_zu
   generated from Powerdesigner on Montag, 15. September 2025 15:20:57
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_optin_statusgrund_spr_zu (
crm_optin_statusgrund_cd STRING(20) NOT NULL
OPTIONS(description='Statusgrund-Code des Optins (liefert Information darüber, ob Erlaubnis erteilt, Erlaubnis nicht erteilt).'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
crm_optin_statusgrund_bez STRING(30) OPTIONS(description='Statusgrund-Bezeichnung des Optins.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_optin_statusgrund_cd, spr_id) NOT ENFORCED
) OPTIONS(description='CRM - Sprachtabelle fuer Optin-Statusgrund aus Cosmos DB CRM.');