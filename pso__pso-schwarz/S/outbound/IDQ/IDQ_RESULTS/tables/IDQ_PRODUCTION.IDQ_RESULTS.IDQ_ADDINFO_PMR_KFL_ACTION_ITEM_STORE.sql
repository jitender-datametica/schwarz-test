CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_pmr_kfl_action_item_store (
id BIGNUMERIC(38,0),
test_object_id BIGNUMERIC(38,0),
branch_id BIGNUMERIC(38,0),
source_system_primary_key STRING(1000),
promotion STRING(100),
item STRING(1000),
store STRING(36),
source_system_id BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0),
is_relevant BIGNUMERIC(38,0),
dmf_ofr_ref_event_id INTEGER,
dmf_ofr_ext_xr_ext_ofr_id STRING(36),
dmf_loc_ext_xr_ext_loc_id STRING(36),
dmf_ofr_changed_on STRING(16),
timestamp_from STRING(16),
timestamp_to STRING(16),
content_hash_code STRING(32)
);