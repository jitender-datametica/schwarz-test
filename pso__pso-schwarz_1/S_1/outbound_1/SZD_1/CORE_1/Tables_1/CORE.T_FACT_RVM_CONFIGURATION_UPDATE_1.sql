CREATE TABLE IF NOT EXISTS szd_core.t_fact_rvm_configuration_update_1 (
rvm_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the despotie machine which is located in a store'),
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). '),
update_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). '),
update_tm TIME NOT NULL
OPTIONS(description='The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). '),
rvm_config_source_cd STRING(50) NOT NULL
OPTIONS(description='The code for the deposit machine configuration source e.g. donwload article meta data 1,...'),
rec_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The number for the configuration update records.'),
update_status_fg BOOL NOT NULL OPTIONS(description='An indicator showing, if the update status_1 has an error'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (cal_dt, rvm_sid, update_dt, update_tm, rvm_config_source_cd) NOT ENFORCED
) OPTIONS(description='Transactional facts capturing the downloading and importing of DPG articles');