CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_pmr_kfl_offer (
id INTEGER,
test_object_id INTEGER,
branch_id INTEGER,
source_system_primary_key STRING(1000),
source_system_id INTEGER,
country_id INTEGER,
is_relevant INTEGER,
dmf_ofr_ext_xr_ext_ofr_id STRING(36),
dmf_ofr_tstmp_fr STRING(16),
dmf_ofr_tstmp_to STRING(16),
dmf_ofr_ofr_state_cd INTEGER,
country_code STRING(5),
content_hash_code STRING(32)
);