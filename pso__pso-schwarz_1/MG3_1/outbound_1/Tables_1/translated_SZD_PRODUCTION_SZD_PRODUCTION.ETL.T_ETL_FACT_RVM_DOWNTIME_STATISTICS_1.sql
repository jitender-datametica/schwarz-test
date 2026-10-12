CREATE OR REPLACE TABLE szd_production_etl.t_etl_fact_rvm_downtime_statistics_1 (
rvm_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the despotie machine which is located in a store'),
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). '),
total_downtime_sec_cnt INTEGER NOT NULL
OPTIONS(description='The number of full outages this machine suffered on this component in the given time interval.'),
downtime_no_electricity_sec_cnt INTEGER NOT NULL
OPTIONS(description='The number of partial outages this machine suffered on this component in the given time interval.'),
downtime_other_rsn_sec_cnt INTEGER NOT NULL
OPTIONS(description='The total time (expressed as a number of seconds) this machine was not operational because of outages of this component in the given time interval.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (rvm_sid, cal_dt) NOT ENFORCED
);