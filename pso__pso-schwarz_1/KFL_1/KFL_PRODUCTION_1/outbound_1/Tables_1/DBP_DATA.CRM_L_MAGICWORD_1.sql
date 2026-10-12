--==============================================================
-- Table: crm_l_magicword_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_magicword_1
   generated from Powerdesigner on Friday, June 24, 2022 1:02:13 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_l_magicword_1 (
crm_magicword_id STRING(36) NOT NULL
OPTIONS(description='Topic related to the content of the ticket which had been defined by the business'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_magicword_id) NOT ENFORCED
) OPTIONS(description='Lookup for magic word surrogate keys (= "Zauberwort" = topic category tag_1 for CRM tickets)');