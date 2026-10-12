CREATE OR REPLACE TABLE ldl_data_production_etl.t_ts_internal_organization_2_tax_class__ (
tax_class_cd STRING(20),
geo_area_sid BIGNUMERIC(38,0),
tax_class_descr STRING(250),
tax_type_cd STRING(20),
dwh_load_id BIGNUMERIC(38,0),
dwh_node_cd STRING(20),
record_id STRING(1000),
deleted_fg BOOL,
error_descr STRING(1000),
filename STRING(1000),
hist_row_no STRING(1000),
dwh_mapping_tmsp TIMESTAMP,
dwh_ending_tmsp TIMESTAMP,
error_fg BIGNUMERIC(38,0)
);