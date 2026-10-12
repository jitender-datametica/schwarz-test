CREATE OR REPLACE TABLE ldl_data_production_meta.t_tf_product_variant_key_2_product_variant_key___1 (
prod_variant_sid INTEGER NOT NULL,
prod_variant_key_type_cd STRING(20) NOT NULL,
prod_variant_nat_key_nr STRING(250) NOT NULL,
source_system STRING(20) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_tmsp TIMESTAMP,
tf_error_fg INTEGER,
deleted_fg INTEGER,
record_id STRING(300),
filename STRING(1000) NOT NULL,
dwh_node_cd STRING(20) NOT NULL,
dwh_load_id INTEGER NOT NULL,
error_descr STRING(1000)
);