CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_employee_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
emp_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the employee.'),
first_name STRING(100) OPTIONS(description='The first name (given name) of the employee.'),
family_name STRING(100) OPTIONS(description='The family name / surname of the employee.'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Article is in case of deleted_fg = 1 not known in the source system in the time frame dwh_valid_from / dwh_valid_to. Note: this is also set ff the loesch-kz in the source system is set.'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (emp_sid, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='An employee_2 is a person who works for the Schwarz Group. This includes full-time and part-time employees, as well as freelancers and external contractors.');