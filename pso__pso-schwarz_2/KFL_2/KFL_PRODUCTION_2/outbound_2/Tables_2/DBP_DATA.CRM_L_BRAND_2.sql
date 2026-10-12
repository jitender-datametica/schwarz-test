--==============================================================
-- Table: crm_l_brand_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_brand_2
   generated from Powerdesigner on Friday, June 24, 2022 1:03:36 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_l_brand_2 (
crm_brand_id STRING(36) NOT NULL OPTIONS(description='ID of brand_2 the customer has a complain abou'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_brand_id) NOT ENFORCED
) OPTIONS(description='Lookup for brand_2 surrogate keys (= brand_2 the customer has a complain about)');