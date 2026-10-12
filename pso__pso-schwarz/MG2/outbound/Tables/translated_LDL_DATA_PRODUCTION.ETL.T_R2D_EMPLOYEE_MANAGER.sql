CREATE OR REPLACE TABLE ldl_data_production_etl.t_r2d_employee_manager (
emp_sid INTEGER,
dwh_valid_from_tmsp TIMESTAMP,
dwh_valid_to_tmsp TIMESTAMP,
emp_mgr_sid INTEGER,
emp_mgr_first_name STRING(100),
emp_mgr_family_name STRING(100)
);