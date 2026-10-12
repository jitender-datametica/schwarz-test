CREATE TABLE IF NOT EXISTS szd_core.t_fact_rvm_monitoring_2 (
rvm_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the despotie machine which is located in a store'),
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). '),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
files_exp_cnt BIGNUMERIC(38,0) OPTIONS(description='The Counter for expected Files'),
files_miss_cnt BIGNUMERIC(38,0) OPTIONS(description='The Counter for missing Files'),
PRIMARY KEY (rvm_sid, cal_dt) NOT ENFORCED
) OPTIONS(description='Transactional facts capturing preventive maintenance operations of deposit machines.');