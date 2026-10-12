CREATE TABLE IF NOT EXISTS szd_core.t_fact_deposit_return_per_hour_2 (
rvm_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the despotie machine which is located in a store'),
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). '),
return_hour BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The code for the deposit item_2 return hour.'),
deposit_item_sub_cat_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The code for the item_2 return type of deposits.'),
deposit_item_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The amount of returned deposit items per hour'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (cal_dt, rvm_sid, deposit_item_sub_cat_id, return_hour) NOT ENFORCED
) OPTIONS(description='Transactional facts capturing returning items per hour');