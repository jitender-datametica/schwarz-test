CREATE OR REPLACE TABLE szd_production_etl.t_etl_fact_rvm_downtime_statistics (
rvm_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the despotie machine which is located in a store'),
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). '),
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