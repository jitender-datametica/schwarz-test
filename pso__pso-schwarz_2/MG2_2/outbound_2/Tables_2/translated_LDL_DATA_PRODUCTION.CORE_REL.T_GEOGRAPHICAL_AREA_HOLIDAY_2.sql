CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_geographical_area_holiday_2 (
cal_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). '),
geo_area_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the geographical area.'),
geo_area_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the discriminator for geographical areas.'),
holiday_cd STRING(100) NOT NULL
OPTIONS(description='The code identifying the type of holiday. E.g. Christmas, Easter Sunday, ...'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
holiday_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the type of a holiday. E.g. public holiday or regional holiday.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (cal_dt, holiday_cd, geo_area_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='A relationship containing the holidays that exist for a certain geographical area. This may be on country_2 level, for a territory or even down to city level. Depending on the location_2, a holiday may be of a different type. E.g. in Catholic regions of Germany August 15th is a public holiday, whereas in Protestant regions it is only a non-recognized holiday.');