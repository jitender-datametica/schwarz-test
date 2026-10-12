CREATE OR REPLACE TABLE ldl_p_lew_core.t_employee (
client_id INTEGER NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
emp_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the employee.'),
emp_nr STRING(100) NOT NULL OPTIONS(description='Employee business number.'),
emp_workforce_nr STRING(100) OPTIONS(description='Employee workforce business number.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'),
PRIMARY KEY (emp_sid) NOT ENFORCED
)
OPTIONS(description='An employee is a person who works for the Schwarz Group. This includes full-time and part-time employees, as well as freelancers and external contractors.');