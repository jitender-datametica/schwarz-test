CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_lookup_flex_1 (
target_core_field STRING(50),
target_core_value STRING(200),
source_field_1 STRING(50),
source_value_1 STRING(200),
source_field_2 STRING(50),
source_value_2 STRING(200),
source_field_3 STRING(50),
source_value_3 STRING(200),
source_field_4 STRING(50),
source_value_4 STRING(200),
lkp_key_explanation STRING(200),
lkp_file_name STRING(200),
no_of_source_fields BIGNUMERIC(38,0),
check_key STRING(1000),
check_count BIGNUMERIC(38,0),
tmsp_insert TIMESTAMP,
tmsp_update TIMESTAMP
);