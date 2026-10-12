CREATE TABLE IF NOT EXISTS ldl_data_core_dim.t_fact_national_holiday_1 (
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). '),
iso_country_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the country_1 according to ISO 3166.'),
holiday_name STRING(100) NOT NULL OPTIONS(description='A name for the holiday in group language, i.e. German.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (cal_dt, iso_country_cd, holiday_name) NOT ENFORCED
)
OPTIONS(description='Public holidays which are defined on country_1 level. (This relation does not include regional holidays!)');