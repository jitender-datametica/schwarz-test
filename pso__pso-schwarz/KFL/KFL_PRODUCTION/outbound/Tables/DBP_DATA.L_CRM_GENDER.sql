--==============================================================
-- Table: l_crm_gender
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_crm_gender
   generated from Powerdesigner on Donnerstag, 28. August 2025 10:50:04
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_crm_gender (
gender_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID für das Geschlecht des Kunden'),
gender_bez STRING(50) DEFAULT 'system generated' OPTIONS(description='Bezeichnung für das Geschlecht des Kunden.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (gender_id) NOT ENFORCED
) OPTIONS(description='CRM - Lookup Tabelle für SalutationCode aus Cosmos DB.');