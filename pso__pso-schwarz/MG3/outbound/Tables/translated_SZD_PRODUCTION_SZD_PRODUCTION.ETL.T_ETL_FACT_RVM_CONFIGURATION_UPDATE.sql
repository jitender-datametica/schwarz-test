CREATE OR REPLACE TABLE szd_production_etl.t_etl_fact_rvm_configuration_update (
rvm_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the despotie machine which is located in a store'),
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). '),
update_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). '),
update_tm TIME NOT NULL
OPTIONS(description='The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). '),
rvm_config_source_cd STRING(50) NOT NULL
OPTIONS(description='The code for the deposit machine configuration source e.g. donwload article meta data 1,...'),
rec_cnt INTEGER NOT NULL OPTIONS(description='The number for the configuration update records.'),
update_status_fg BOOL NOT NULL OPTIONS(description='An indicator showing, if the update status has an error'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (cal_dt, rvm_sid, update_dt, update_tm, rvm_config_source_cd) NOT ENFORCED
);