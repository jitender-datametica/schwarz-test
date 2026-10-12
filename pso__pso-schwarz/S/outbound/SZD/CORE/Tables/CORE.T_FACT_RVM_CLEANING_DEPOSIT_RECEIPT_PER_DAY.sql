/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_RVM_CLEANING_DEPOSIT_RECEIPT_PER_DAY
   generated from Powerdesigner on Montag, 10. November 2025 12:06:23
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_fact_rvm_cleaning_deposit_receipt_per_day (
rvm_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the despotie machine which is located in a store'),
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). '),
cleaning_type_cd STRING(50) NOT NULL OPTIONS(description='The code for the cleaning type'),
cleaning_status_cd STRING(50) NOT NULL OPTIONS(description='The code for the cleaning status'),
deposit_receipt_printed_fg BOOL NOT NULL
OPTIONS(description='The flag showing if there was a deposit receipt printed from the RVM on a particular day.'),
cleaning_dur_sec_cnt BIGNUMERIC(38,0) OPTIONS(description='The analytical fact for the cleaning duration time'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (rvm_sid, cal_dt, cleaning_type_cd, cleaning_status_cd) NOT ENFORCED
)
OPTIONS(description='Fact table - Analytical - Granularity by rvm, day, cleaning type and cleaning status - Aggregate - Contains the data about the cleaning of a Reverse Vending Machine and whether a Deposit Receipt was also printed on the daily basis. - Source - T_FACT_RVM_CLEANING and T_FACT_DEPOSIT_RECEIPT.');