CREATE TABLE IF NOT EXISTS ldl_data_etl.t_r2d_real_estate_replacement (
real_estate_sid BIGNUMERIC(38,0),
dwh_valid_from_tmsp TIMESTAMP,
dwh_valid_to_tmsp TIMESTAMP,
replacement_real_estate_sid BIGNUMERIC(38,0),
replacement_real_estate_nr STRING(20),
replacement_real_estate_name STRING(100),
real_estate_replacement_type_cd STRING(20),
real_estate_replacement_type_descr STRING(250)
);