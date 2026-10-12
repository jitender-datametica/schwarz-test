CREATE TABLE IF NOT EXISTS szd_core.t_fact_deposit_return_per_hour (
rvm_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the despotie machine which is located in a store'),
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). '),
return_hour BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The code for the deposit item return hour.'),
deposit_item_sub_cat_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The code for the item return type of deposits.'),
deposit_item_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The amount of returned deposit items per hour'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (cal_dt, rvm_sid, deposit_item_sub_cat_id, return_hour) NOT ENFORCED
) OPTIONS(description='Transactional facts capturing returning items per hour');