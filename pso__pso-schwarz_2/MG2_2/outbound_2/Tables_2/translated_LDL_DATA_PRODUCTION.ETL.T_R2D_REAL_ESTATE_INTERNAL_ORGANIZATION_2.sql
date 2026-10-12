CREATE OR REPLACE TABLE ldl_data_production_etl.t_r2d_real_estate_internal_organization_2 (
real_estate_sid INTEGER,
int_org_sid INTEGER,
dwh_valid_from_tmsp TIMESTAMP,
dwh_valid_to_tmsp TIMESTAMP,
curr_int_org_nr STRING(20),
int_org_name STRING(100),
int_org_type_cd STRING(20),
int_org_type_descr STRING(250),
store_real_estate_type_cd STRING(20),
store_real_estate_type_descr STRING(250)
);