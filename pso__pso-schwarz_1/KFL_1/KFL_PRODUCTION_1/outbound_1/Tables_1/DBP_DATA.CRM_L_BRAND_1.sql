--==============================================================
-- Table: crm_l_brand_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_brand_1
   generated from Powerdesigner on Friday, June 24, 2022 1:03:36 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_l_brand_1 (
crm_brand_id STRING(36) NOT NULL OPTIONS(description='ID of brand_1 the customer has a complain abou'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_brand_id) NOT ENFORCED
) OPTIONS(description='Lookup for brand_1 surrogate keys (= brand_1 the customer has a complain about)');