CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_zsm_kfl_item_2 (
id BIGNUMERIC(38,0) NOT NULL,
test_object_id BIGNUMERIC(38,0),
source_system_primary_key STRING(1000),
source_system_id BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0),
branch_id BIGNUMERIC(38,0),
is_relevant BIGNUMERIC(38,0),
zsm_matnr STRING(18),
zsm_mstae STRING(2),
zsm_wekgr STRING(3),
content_hash_code STRING(32),
PRIMARY KEY (id) NOT ENFORCED
);