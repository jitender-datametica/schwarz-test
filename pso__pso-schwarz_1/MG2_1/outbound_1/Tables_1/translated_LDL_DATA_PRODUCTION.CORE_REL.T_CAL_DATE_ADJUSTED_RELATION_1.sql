CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_cal_date_adjusted_relation_1 (
cal_dt DATE NOT NULL
OPTIONS(description='The day being mapped back to previous (business) years, represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). '),
bus_year_diff INTEGER NOT NULL
OPTIONS(description='The difference in years between the current business year and the business year we are mapping back to. I.e. 1 for the previous year, 2 for 2 years ago etc.'),
incl_cal_dt DATE NOT NULL
OPTIONS(description='The date that needs to be included for the previous year\'s equivalent of the current day being mapped.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (cal_dt, bus_year_diff, incl_cal_dt) NOT ENFORCED
)
OPTIONS(description='This table maps a calendar_1 date to its equivalent day(s) of previous business years maintaining the same weekday. Mappings for days at the end of the business year are adjusted, so that all mapped days belong to the same business year. In case of leap years this is a many-to-many relation.');