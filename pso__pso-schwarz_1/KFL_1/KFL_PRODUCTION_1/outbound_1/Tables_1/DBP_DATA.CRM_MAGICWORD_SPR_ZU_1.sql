--==============================================================
-- Table: crm_magicword_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_magicword_spr_zu_1
   generated from Powerdesigner on Friday, June 24, 2022 1:05:45 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_magicword_spr_zu_1 (
crm_magicword_id STRING(36) NOT NULL
OPTIONS(description='Topic related to the content of the ticket which had been defined by the business'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='country_1 ID'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='language ID'),
crm_magicword_bez STRING(100) OPTIONS(description='description of the magic word'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_magicword_id, mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='Spr_zu für magic word surrogate keys (= "Zauberwort" = topic category tag_1 for CRM tickets)');