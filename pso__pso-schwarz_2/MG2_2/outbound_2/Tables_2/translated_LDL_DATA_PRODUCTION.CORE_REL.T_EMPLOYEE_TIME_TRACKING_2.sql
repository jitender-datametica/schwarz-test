CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_employee_time_tracking_2 (
int_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the internal organization to which the time booking is accrued.'),
emp_hash STRING(32) NOT NULL OPTIONS(description='The encrypted employee_2 number.'),
bus_dt DATE NOT NULL OPTIONS(description='The business date to which the time record relates.'),
emp_tm_tracking_nr INTEGER NOT NULL
OPTIONS(description='A number identifying the time booking record in the operational system.'),
emp_tm_tracking_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the subtype discriminator for administrative events.'),
emp_tm_tracking_method_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way, how employees track their time. Time records can be recorded by a terminal or can be entered manually.'),
emp_tm_tracking_status_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the lifecycle status_2 for employee_2 time tracking records. A record may be active or cancelled.'),
emp_tm_event_type_cd STRING(20)
OPTIONS(description='The code identifying the kind time recording event which is booked for an employee. This includes start of work, end of work, start of break and end of break.'),
tm_tracking_tmsp TIMESTAMP
OPTIONS(description='The point in time when the time tracking record was created.'),
emp_tm_period_type_sid INTEGER
OPTIONS(description='The unique identifier (surrogate key) for the type of time which is booked for an employee_2, e.g. work time, holidays, training, etc.'),
period_start_tmsp TIMESTAMP
OPTIONS(description='The start timestamp of the time period which is tracked.'),
period_end_tmsp TIMESTAMP
OPTIONS(description='The end timestamp of the time period which is tracked.'),
hr_cnt NUMERIC(29,2) OPTIONS(description='The number of hours which are booked. This time does not include breaks'),
break_min_cnt INTEGER OPTIONS(description='Break time in minutes.'),
booking_dt DATE OPTIONS(description='The date when the time booking was recorded in the operational system.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (int_org_sid, emp_hash, bus_dt, emp_tm_tracking_nr) NOT ENFORCED
)
OPTIONS(description='Employees track their work times, as well as their absences and other activities, such as training.');