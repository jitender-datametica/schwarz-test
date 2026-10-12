CREATE OR REPLACE TABLE ldl_dig_production_etl_process.t_etl_product_variant_rel_src (
primary_src_name STRING(100),
primary_prod_variant_nr STRING(100),
secondary_src_name STRING(100),
secondary_prod_variant_nr STRING(100),
src_table_name STRING(100),
src_file_tmsp TIMESTAMP
);