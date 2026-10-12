CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_cash_register_1 (
cash_register_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the cash register.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
cash_register_nr INTEGER NOT NULL OPTIONS(description='The number which identifies the cash register.'),
real_estate_sid INTEGER OPTIONS(description='The unique identifier (surrogate key) for the real estate object.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (cash_register_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='A cash register is an electronic device which is used in stores to record sales_1 transactions. It typically includes a bar code scanner, a keyboard, a display and a drawer for money.');