CREATE OR REPLACE TABLE szd_production_etl_process.t_cache_batch_product_2 (
ian_nr STRING(50),
prod_batch_nr STRING(50),
prod_key_type_cd STRING(50),
prod_id STRING(100),
prod_name STRING(400),
prod_division_type_cd STRING(50),
incoterm_name STRING(100),
hs_list_txt STRING(2000),
dwh_src_file_name STRING(500),
dwh_src_tmsp TIMESTAMP,
product_status_cd STRING(1),
valid_from TIMESTAMP,
dwh_load_id INTEGER,
dwh_created_tmsp TIMESTAMP,
dwh_updated_tmsp TIMESTAMP,
dwh_node_cd STRING(20)
);