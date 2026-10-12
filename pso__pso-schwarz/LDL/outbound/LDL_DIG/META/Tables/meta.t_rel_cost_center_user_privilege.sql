CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_rel_cost_center_user_privilege (
username STRING(50) OPTIONS(description='Username of the user (Lidl Digital employee)'),
full_mstr_login_name STRING(100) NOT NULL OPTIONS(description='Microstrategy login of the user (Lidl Digital employee)'),
fiscal_year BIGNUMERIC(38,0) NOT NULL OPTIONS(description='A number that represents the fiscal year of the hierarchy'),
cost_center_nr STRING(20) NOT NULL OPTIONS(description='Identifier of the Cost Center'),
dwh_created_tmsp DATETIME,
dwh_updated_tmsp DATETIME,
dwh_src_file_name STRING(16777216),
src_file_tmsp DATETIME,
PRIMARY KEY (full_mstr_login_name, fiscal_year, cost_center_nr) NOT ENFORCED
) OPTIONS(description='This table contains users information and all the cost centers they have privileges for');