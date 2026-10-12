CREATE OR REPLACE TABLE szd_production_etl.t_etl_fact_cabinet_usage_2 (
rvm_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the despotie machine which is located in a store'),
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). '),
compactor_id STRING(20) NOT NULL OPTIONS(description='The identifier for the amount of Compactors under a cabinet.'),
compacted_bottles_cnt INTEGER NOT NULL
OPTIONS(description='The transactional facts for the amount of compacted bottles'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
cabinet_id INTEGER NOT NULL OPTIONS(description='The identifier for the amount of Cabinets in a RVM'),
PRIMARY KEY (rvm_sid, cal_dt, cabinet_id) NOT ENFORCED
);