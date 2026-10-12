CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_employee_time_period_type_1 (
emp_tm_period_type_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the type of time which is booked for an employee_1, e.g. work time, holidays, training, etc.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
country_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country_1 organization which uses this time period type.'),
emp_tm_period_type_id INTEGER NOT NULL
OPTIONS(description='The numeric identifier of the type of time which is booked for an employee_1, e.g. work time, holidays, training, etc. The identifier is specific to the country_1 organization.'),
emp_tm_period_type_cd STRING(20)
OPTIONS(description='The code which identifies the type of time which is booked for an employee_1, e.g. work time, holidays, training, etc. The code is specific to the country_1 organization.'),
emp_tm_period_type_short_descr STRING(250)
OPTIONS(description='A short textual description / abbreviation for the type of time which is booked for an employee_1, e.g. work time, holidays, training, etc.'),
emp_tm_period_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the type of time which is booked for an employee_1, e.g. work time, holidays, training, etc.'),
perf_relevant_fg BOOL
OPTIONS(description='An indicator showing, if the time period type is to be considered for calculating the net hours KPI.'),
on_site_fg BOOL OPTIONS(description='An indicator showing, if work was performed on-site.'),
active_from_dt DATE NOT NULL OPTIONS(description='The date when this record becomes valid from a business perspective.'),
active_to_dt DATE NOT NULL
OPTIONS(description='The date when this record is no longer valid from a business perspective.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (emp_tm_period_type_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the type of time which is booked for an employee_1, e.g. work time, holidays, training, etc.');