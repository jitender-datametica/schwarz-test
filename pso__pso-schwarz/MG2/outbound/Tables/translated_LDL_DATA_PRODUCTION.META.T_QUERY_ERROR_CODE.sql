CREATE OR REPLACE TABLE ldl_data_production_meta.t_query_error_code (
query_error_cd STRING(20) NOT NULL OPTIONS(description='The error code, as defined by the database engine.'),
query_error_descr STRING(250) NOT NULL OPTIONS(description='The description for the error.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (query_error_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the SQL error codes for a query. If a query was executed successfully, the error code is empty.');