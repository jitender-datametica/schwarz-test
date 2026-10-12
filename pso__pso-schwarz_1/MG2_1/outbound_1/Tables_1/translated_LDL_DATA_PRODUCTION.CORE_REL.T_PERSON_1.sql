CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_person_1 (
person_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the person.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
gender_cd STRING(20) NOT NULL OPTIONS(description='The code identifying the gender.'),
first_name STRING(100) OPTIONS(description='The first name (given name) of the person.'),
family_name STRING(100) OPTIONS(description='The family name / surname of the person.'),
birth_dt DATE OPTIONS(description='The date when the person was born.'),
is_cust_fg BOOL NOT NULL OPTIONS(description='An indicator showing, if the person is a customer.'),
is_emp_fg BOOL NOT NULL OPTIONS(description='An indicator showing, if the person is a employee.'),
is_buyer_fg BOOL OPTIONS(description='An indicator showing, if the employee_1 as the role of a buyer.'),
is_data_steward_fg BOOL OPTIONS(description='An indicator showing, if the employee_1 is a data steward.'),
is_cashier_fg BOOL OPTIONS(description='An indicator showing, if the employee_1 is a cashier.'),
emp_nr STRING(20)
OPTIONS(description='The number which identifies the employee. In case the employee_1 leaves and gets re_1-hired later on, he might get a different employee_1 number.'),
buyer_nr STRING(20) OPTIONS(description='The number which identifies the buyer within the organization.'),
hire_dt DATE
OPTIONS(description='The date when the employee_1 was hired. In case the employee_1 leaves the organization and gets re_1-hired later on, this is the latest hire date.'),
term_dt DATE
OPTIONS(description='The date, when the employee_1 left the organization. For active employees this date is empty.'),
mgr_emp_sid INTEGER OPTIONS(description='The unique identifier (surrogate key) for the manager of the employee.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (person_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='People who are of interest to the Schwarz Group.');