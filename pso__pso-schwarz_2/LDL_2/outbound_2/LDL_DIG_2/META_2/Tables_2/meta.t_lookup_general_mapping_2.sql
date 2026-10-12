CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_lookup_general_mapping_2 (
target_core_field STRING(50) NOT NULL,
target_core_value STRING(200),
source_system STRING(30) NOT NULL,
source_client STRING(5) NOT NULL,
source_field_1 STRING(50) NOT NULL,
source_value_1 STRING(200) NOT NULL,
source_field_2 STRING(50),
source_value_2 STRING(200),
source_field_3 STRING(50),
source_value_3 STRING(200),
check_key STRING(1000),
check_count BIGNUMERIC(38,0),
tmsp_insert TIMESTAMP,
tmsp_update TIMESTAMP,
PRIMARY KEY (target_core_field, source_system, source_client, source_field_1, source_value_1) NOT ENFORCED
);