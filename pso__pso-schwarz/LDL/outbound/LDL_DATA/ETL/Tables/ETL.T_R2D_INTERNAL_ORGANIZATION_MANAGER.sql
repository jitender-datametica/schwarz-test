CREATE TABLE IF NOT EXISTS ldl_data_etl.t_r2d_internal_organization_manager (
int_org_sid BIGNUMERIC(38,0),
job_role_type_cd STRING(100),
dwh_valid_from_tmsp TIMESTAMP,
dwh_valid_to_tmsp TIMESTAMP,
int_org_mgr_sid BIGNUMERIC(38,0),
int_org_mgr_nr STRING(20),
int_org_mgr_first_name STRING(100),
int_org_mgr_last_name STRING(100),
int_org_mgr_full_name STRING(200)
);