CREATE OR REPLACE TABLE szd_production_core.t_fact_rvm_monitoring (
rvm_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the despotie machine which is located in a store'),
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). '),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
files_exp_cnt INTEGER OPTIONS(description='The Counter for expected Files'),
files_miss_cnt INTEGER OPTIONS(description='The Counter for missing Files'),
PRIMARY KEY (rvm_sid, cal_dt) NOT ENFORCED
) OPTIONS(description='Transactional facts capturing preventive maintenance operations of deposit machines.');