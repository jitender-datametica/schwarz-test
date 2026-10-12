CREATE OR REPLACE TABLE ldl_data_production_core_dim.t_dim_flag_2 (
fg BOOL NOT NULL OPTIONS(description='The flag (true or false)'),
fg_name STRING(100) NOT NULL OPTIONS(description='The name for the flag (yes / no) in group language, i.e. German.'),
fg_name_de STRING(100) OPTIONS(description='The name for the flag (yes / no) in.German.'),
fg_name_en STRING(100) OPTIONS(description='The name for the flag (yes / no) in English.'),
fg_short_name STRING(100) NOT NULL
OPTIONS(description='The abbreviation for the flag (Y/N) in group language, i.e. German.'),
fg_short_name_de STRING(100) OPTIONS(description='The abbreviation for the flag (Y/N) in.German.'),
fg_short_name_en STRING(100) OPTIONS(description='The abbreviation for the flag (Y/N) in English.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (fg) NOT ENFORCED
)
OPTIONS(description='If the frontend requires a list of values for flags (i.e. true and false), this minor dimension can be used as a lookup.');