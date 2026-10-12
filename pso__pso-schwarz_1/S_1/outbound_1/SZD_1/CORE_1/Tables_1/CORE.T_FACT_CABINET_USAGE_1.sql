CREATE TABLE IF NOT EXISTS szd_core.t_fact_cabinet_usage_1 (
rvm_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the despotie machine which is located in a store'),
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). '),
compactor_id STRING(20) NOT NULL OPTIONS(description='The identifier for the amount of Compactors under a cabinet.'),
cabinet_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The identifier for the amount of Cabinets in a RVM'),
compacted_bottles_cnt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The transactional facts for the amount of compacted bottles'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (rvm_sid, cal_dt, cabinet_id) NOT ENFORCED
) OPTIONS(description='Transactional facts capturing the cabinets of deposit machines');