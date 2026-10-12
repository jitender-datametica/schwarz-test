CREATE OR REPLACE TABLE ldl_data_production_meta.t_data_quality_issue_contact_role_1 (
dq_issue_contact_role_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the role, which the contact_1 person plays in the context of the data quality issue. E.g. an employee_1 may be the primary contact_1 for analyzing the issue or a secondary contact_1 for resolving the issue.'),
dq_issue_contact_role_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the role, which the contact_1 person plays in the context of the data quality issue. E.g. an employee_1 may be the primary contact_1 for analyzing the issue or a secondary contact_1 for resolving the issue.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (dq_issue_contact_role_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines, which role the contact_1 person plays in the context of the data quality issue. E.g. an employee_1 may be the primary contact_1 for analyzing the issue or a secondary contact_1 for resolving the issue.');