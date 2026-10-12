CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_cal_cum_month_to_partial_week_1 (
part_week BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The partial week for which the month-to-partial-year interval is defined'),
incl_part_week BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The partial that needs to be included in the month-to-partial-week interval.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (part_week, incl_part_week) NOT ENFORCED
)
OPTIONS(description='This table relates a partial week to all partial weeks that form its month-to-partial-week interval.');