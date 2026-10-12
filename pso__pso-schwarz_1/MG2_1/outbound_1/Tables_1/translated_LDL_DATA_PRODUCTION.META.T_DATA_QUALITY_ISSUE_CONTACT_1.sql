CREATE OR REPLACE TABLE ldl_data_production_meta.t_data_quality_issue_contact_1 (
dq_issue_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the data quality issue.'),
emp_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the employee.'),
dq_issue_contact_role_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the role, which the contact_1 person plays in the context of the data quality issue. E.g. an employee_1 may be the primary contact_1 for analyzing the issue or a secondary contact_1 for resolving the issue.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (dq_issue_sid, emp_sid, dwh_valid_from_tmsp, dq_issue_contact_role_cd) NOT ENFORCED
)
OPTIONS(description='Data quality issues get handled by various employees. There are people who analyze the problem, while other employees work on its resolution. This entity tracks the relation between a data quality issue and all employees which are involved in analyzing and resolving it.');