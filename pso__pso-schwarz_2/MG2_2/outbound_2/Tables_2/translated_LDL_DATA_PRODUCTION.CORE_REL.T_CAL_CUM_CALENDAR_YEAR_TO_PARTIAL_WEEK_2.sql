CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_cal_cum_calendar_year_to_partial_week_2 (
part_week INTEGER NOT NULL
OPTIONS(description='The partial week for which the calendar_2-year-to-partial-week interval is defined'),
incl_part_week INTEGER NOT NULL
OPTIONS(description='The partial week that needs to be included in the calendar_2-year-to-partial-week interval.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (part_week, incl_part_week) NOT ENFORCED
)
OPTIONS(description='This table relates a partial week to all partial weeks that form its calendar_2-year-to-partial-week interval.');