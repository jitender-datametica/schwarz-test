--==============================================================
-- Table: crm_vorgang_fremdkoerper_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_vorgang_fremdkoerper_zu
   generated from Powerdesigner on Wednesday, July 20, 2022 10:31:04 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_vorgang_fremdkoerper_zu (
crm_vorgang_id STRING(36) COLLATE 'und:ci' DEFAULT '-1' NOT NULL OPTIONS(description='Vorgang ID (GUID) aus CRM'),
crm_fremdkoerper_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Art der Verunreinigung ID'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_fremdkoerper_id) NOT ENFORCED
) OPTIONS(description='A relationship table that links crm_vorgang and crm_l_fremdkoerper');