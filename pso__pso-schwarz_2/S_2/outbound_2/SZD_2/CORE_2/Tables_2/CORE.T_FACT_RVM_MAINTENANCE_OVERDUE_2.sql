CREATE TABLE IF NOT EXISTS szd_core.t_fact_rvm_maintenance_overdue_2 (
rvm_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the despotie machine which is located in a store'),
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). '),
prev_action_dt DATE NOT NULL
OPTIONS(description='The date when preventive maintenance was carried out on the deposit machine.'),
due_dt_from DATE NOT NULL OPTIONS(description='the start of the maintenance due date '),
due_dt_to DATE NOT NULL OPTIONS(description='the end of the maintenance due date '),
overdue_day_cnt BIGNUMERIC NOT NULL OPTIONS(description='The count of days the maintenance is overdue'),
overdue_cnt BIGNUMERIC NOT NULL OPTIONS(description='The count of rvms with maintenance overdue as constant 1'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (rvm_sid, cal_dt) NOT ENFORCED
) OPTIONS(description='Transactional facts capturing the maintenance overdue of RVMs');