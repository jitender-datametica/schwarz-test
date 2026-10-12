/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_RVM_CLEANING_DEPOSIT_RECEIPT_PER_DAY_1
   generated from Powerdesigner on Montag, 10. November 2025 12:06:23
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_fact_rvm_cleaning_deposit_receipt_per_day_1 (
rvm_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the despotie machine which is located in a store'),
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). '),
cleaning_type_cd STRING(50) NOT NULL OPTIONS(description='The code for the cleaning type'),
cleaning_status_cd STRING(50) NOT NULL OPTIONS(description='The code for the cleaning status_1'),
deposit_receipt_printed_fg BOOL NOT NULL
OPTIONS(description='The flag showing if there was a deposit receipt printed from the RVM on a particular day.'),
cleaning_dur_sec_cnt BIGNUMERIC(38,0) OPTIONS(description='The analytical fact for the cleaning duration time'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (rvm_sid, cal_dt, cleaning_type_cd, cleaning_status_cd) NOT ENFORCED
)
OPTIONS(description='Fact table - Analytical - Granularity by rvm, day, cleaning type and cleaning status_1 - Aggregate - Contains the data about the cleaning of a Reverse Vending Machine and whether a Deposit Receipt was also printed on the daily basis. - Source - T_FACT_RVM_CLEANING_1 and T_FACT_DEPOSIT_RECEIPT.');