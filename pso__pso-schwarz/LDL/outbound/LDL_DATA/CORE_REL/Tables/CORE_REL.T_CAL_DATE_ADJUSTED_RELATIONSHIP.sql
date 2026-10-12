CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_cal_date_adjusted_relationship (
cal_dt DATE NOT NULL
OPTIONS(description='The day being mapped back to previous (business) years, represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). '),
cal_dt_adjust_type_cd STRING(20) NOT NULL
OPTIONS(description='A code for the rule, which defines, how a calendar date is related to its equivalent day(s) in the previous year(s).'),
bus_year_diff BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The difference in years between the current business year and the business year we are mapping back to. I.e. 1 for the previous year, 2 for 2 years ago etc.'),
rel_cal_dt DATE NOT NULL OPTIONS(description='The equivalent calendar date n year(s) in the past.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (cal_dt, cal_dt_adjust_type_cd, bus_year_diff, rel_cal_dt) NOT ENFORCED
)
OPTIONS(description='This table maps a calendar date to its equivalent day(s) in the previous business years, maintaining the same weekday. In case of leap years this is a many-to-many relation. As this mapping can be done in various ways, the adjustment type defines the rule, how the mapping is done. One rule is used on month-level. E.g. 28th of February 2021 is mapped to both 28th and 29 of February 2020. Another rule maps the 28 of February 2021 to both March 1st and March 2nd of 2019, so that the integrity of business years is maintained.');