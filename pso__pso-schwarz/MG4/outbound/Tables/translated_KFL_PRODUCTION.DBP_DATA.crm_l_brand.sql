CREATE OR REPLACE TABLE kfl_production_dbp_data.crm_l_brand (
crm_brand_id STRING(36) NOT NULL OPTIONS(description='ID of brand the customer has a complain abou'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_brand_id) NOT ENFORCED
) OPTIONS(description='Lookup for brand surrogate keys (= brand the customer has a complain about)');