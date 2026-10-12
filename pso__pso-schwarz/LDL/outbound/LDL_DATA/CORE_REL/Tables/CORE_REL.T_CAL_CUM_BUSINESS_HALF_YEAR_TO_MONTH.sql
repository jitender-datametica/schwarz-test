CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_cal_cum_business_half_year_to_month (
cal_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar month for which the business-half-year-to-month interval is defined.'),
incl_cal_month BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar month that needs to be included in the business-half-year-to-month interval.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (cal_month, incl_cal_month) NOT ENFORCED
)
OPTIONS(description='This table relates a month to all months that form the business-half-year-to-month interval of this month. E.g. for May 2019 this is March, April and May 2019.');