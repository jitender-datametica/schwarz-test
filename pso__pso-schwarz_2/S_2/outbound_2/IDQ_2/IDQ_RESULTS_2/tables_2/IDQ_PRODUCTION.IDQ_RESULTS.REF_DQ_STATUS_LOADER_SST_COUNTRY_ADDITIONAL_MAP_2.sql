CREATE OR REPLACE TABLE idq_production_idq_results.ref_dq_status_loader_sst_country_additional_map_2 (
id BIGNUMERIC(38,0) NOT NULL,
source_system_type_id BIGNUMERIC(38,0) NOT NULL,
source_country_id BIGNUMERIC(38,0),
target_country_id_list STRING(400)
);