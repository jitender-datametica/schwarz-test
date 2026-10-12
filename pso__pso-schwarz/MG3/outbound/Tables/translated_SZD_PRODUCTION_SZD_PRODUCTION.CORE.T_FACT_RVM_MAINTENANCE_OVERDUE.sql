CREATE OR REPLACE TABLE szd_production_core.t_fact_rvm_maintenance_overdue (
rvm_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the despotie machine which is located in a store'),
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). '),
prev_action_dt DATE NOT NULL
OPTIONS(description='The date when preventive maintenance was carried out on the deposit machine.'),
due_dt_from DATE NOT NULL OPTIONS(description='the start of the maintenance due date '),
due_dt_to DATE NOT NULL OPTIONS(description='the end of the maintenance due date '),
overdue_day_cnt INTEGER NOT NULL OPTIONS(description='The count of days the maintenance is overdue'),
overdue_cnt INTEGER NOT NULL OPTIONS(description='The count of rvms with maintenance overdue as constant 1'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (rvm_sid, cal_dt) NOT ENFORCED
) OPTIONS(description='Transactional facts capturing the maintenance overdue of RVMs');