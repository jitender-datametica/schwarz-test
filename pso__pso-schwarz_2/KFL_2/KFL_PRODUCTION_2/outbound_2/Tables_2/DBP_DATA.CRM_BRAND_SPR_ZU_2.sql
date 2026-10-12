--==============================================================
-- Table: crm_brand_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_brand_spr_zu_2
   generated from Powerdesigner on Friday, June 24, 2022 1:04:31 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_brand_spr_zu_2 (
crm_brand_id STRING(36) NOT NULL OPTIONS(description='ID of brand_2 the customer has a complain abou'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='country_2 ID'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='language ID'),
crm_brand_bez STRING(100) OPTIONS(description='description of the brand_2'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_brand_id, mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='Spr_zu for brand_2 surrogate keys (= brand_2 the customer has a complain about)');