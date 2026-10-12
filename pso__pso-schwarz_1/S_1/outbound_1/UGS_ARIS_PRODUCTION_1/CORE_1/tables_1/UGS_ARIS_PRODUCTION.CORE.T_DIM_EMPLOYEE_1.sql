CREATE OR REPLACE TABLE ugs_aris_production_core.t_dim_employee_1 (
emp_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the employee.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
emp_name STRING(100) NOT NULL OPTIONS(description='The name (first name and last name) of the employee.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(100)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.')
)
OPTIONS(description='An employee_1 is a natural person working for the Schwarz Group. This inludes full-time and part-time employees as well as external partners and contractors.');