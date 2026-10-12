create table if not exists SZD_PRODUCTION.core.t_fact_rvm_cleaning_deposit_receipt_per_day_1 (
	rvm_sid number(38,0) not null comment 'the unique identifier (surrogate key) for the despotie machine which is located in a store',
	cal_dt date not null comment 'the day represented as a calendar_1 date of the form yyyy-mm_1-dd. yyyy is the calendar_1 year, mm_1 (between 1 and 12) the calendar_1 month and dd the day of the calendar_1 month (between 1 and 31). ',
	cleaning_type_cd varchar(50) not null comment 'the code for the cleaning type',
	cleaning_status_cd varchar(50) not null comment 'the code for the cleaning status_1',
	deposit_receipt_printed_fg boolean not null comment 'the flag showing if there was a deposit receipt printed from the rvm on a particular day.',
	cleaning_dur_sec_cnt number(38,0) comment 'the analytical fact for the cleaning duration time',
	dwh_created_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was inserted into the table.',
	dwh_updated_tmsp timestamp_ltz(9) not null comment 'the point in time when this record was last modified. (in case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint pk_t_fact_rvm_cleaning_deposit_receipt_per_day primary key (rvm_sid, cal_dt, cleaning_type_cd, cleaning_status_cd)
)comment='fact table - analytical - granularity by rvm, day, cleaning type and cleaning status_1 - aggregate - contains the data about the cleaning of a reverse vending machine and whether a deposit receipt was also printed on the daily basis. - source - t_fact_rvm_cleaning_1 and t_fact_deposit_receipt.'
;