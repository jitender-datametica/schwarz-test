CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_real_estate_closing_plan (
real_estate_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the real estate object.'),
closed_from_dt DATE NOT NULL
OPTIONS(description='The start date (inclusive) of the interval for which the real estate object will be closed.'),
closed_until_dt DATE NOT NULL
OPTIONS(description='The end date (inclusive) of the interval for which the real estate object will be closed.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
closed_bus_days_cnt INTEGER NOT NULL
OPTIONS(description='The number of business days the real estate object will remain closed - which it would otherwise have been open.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (real_estate_sid, closed_from_dt, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='This entity tracks the planned closing of a real estate object.');