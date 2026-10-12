CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_telephone_number (
phone_nr_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the telephone number'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
phone_nr STRING(100) NOT NULL
OPTIONS(description='A telephone or fax number, typically consisting of a country code, an area code and a local number.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (phone_nr_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='A telephone or fax number, typically consisting of a country code, an area code and a local number. A telephone number may be used for voice, fax or modem connections.');