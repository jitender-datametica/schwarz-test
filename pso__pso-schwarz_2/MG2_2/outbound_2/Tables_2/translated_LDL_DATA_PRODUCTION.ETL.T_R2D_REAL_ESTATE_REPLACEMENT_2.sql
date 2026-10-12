CREATE OR REPLACE TABLE ldl_data_production_etl.t_r2d_real_estate_replacement_2 (
real_estate_sid INTEGER,
dwh_valid_from_tmsp TIMESTAMP,
dwh_valid_to_tmsp TIMESTAMP,
replacement_real_estate_sid INTEGER,
replacement_real_estate_nr STRING(20),
replacement_real_estate_name STRING(100),
real_estate_replacement_type_cd STRING(20),
real_estate_replacement_type_descr STRING(250)
);