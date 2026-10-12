--==============================================================
-- Table: crm_brand_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_brand_spr_zu
   generated from Powerdesigner on Friday, June 24, 2022 1:04:31 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_brand_spr_zu (
crm_brand_id STRING(36) NOT NULL OPTIONS(description='ID of brand the customer has a complain abou'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='country ID'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='language ID'),
crm_brand_bez STRING(100) OPTIONS(description='description of the brand'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_brand_id, mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='Spr_zu for brand surrogate keys (= brand the customer has a complain about)');