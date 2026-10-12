CREATE TABLE IF NOT EXISTS ldl_data_etl.t_r2d_employee_manager_2 (
emp_sid BIGNUMERIC(38,0),
dwh_valid_from_tmsp TIMESTAMP,
dwh_valid_to_tmsp TIMESTAMP,
emp_mgr_sid BIGNUMERIC(38,0),
emp_mgr_first_name STRING(100),
emp_mgr_family_name STRING(100)
);