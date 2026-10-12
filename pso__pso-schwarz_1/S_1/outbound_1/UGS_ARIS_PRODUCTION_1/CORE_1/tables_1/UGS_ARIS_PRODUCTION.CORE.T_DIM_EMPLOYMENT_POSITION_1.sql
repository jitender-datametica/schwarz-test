CREATE OR REPLACE TABLE ugs_aris_production_core.t_dim_employment_position_1 (
dwh_tenant_cd STRING(8) NOT NULL OPTIONS(description='The code for the data warehoue tenant.'),
emp_pos_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the employment position.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
emp_pos_name STRING(100) NOT NULL OPTIONS(description='The name of the employment positon.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(100)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.')
)
OPTIONS(description='An employment position is a job role within the Schwarz Group, typically associated with certain responsibilities and / or rights. An employment position is usually filled by an employee_1 (or possibly an external contractor). The assignment of an employee_1 to an employment position may change over time, and an employment position may be vacant for a certain period of time. The relation between an employment position and an employee_1 is not necessarily 1:1. An employment position might be filled by two (part-time) employees, or an employee_1 may work in two different positions.');