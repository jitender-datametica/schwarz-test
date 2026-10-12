CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_cal_cum_calendar_year_to_half_year_2 (
cal_half_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar_2 half year for which the calendar_2-year-to-half-year interval is defined.'),
incl_cal_half_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The calendar_2 half year that needs to be included in the calendar_2-year-to-half-year interval.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (cal_half_year, incl_cal_half_year) NOT ENFORCED
)
OPTIONS(description='This table relates a calendar_2 half year to all calendar_2 half years that form the calendar_2-half-year-to-year interval of this business half year. E.g. for the20211 this is 20211 and 20212.');