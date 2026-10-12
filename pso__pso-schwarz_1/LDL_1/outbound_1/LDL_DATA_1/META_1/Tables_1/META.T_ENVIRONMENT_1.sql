/* --------------------------------------------------------------------------------
   DDL for table: t_environment_1
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_meta.t_environment_1 (
env_cd STRING(20) NOT NULL
OPTIONS(description='The code which identifies the (development / test_1 / production / ...) environment.'),
env_name STRING(100) OPTIONS(description='The name of the i(development / test_1 / production / ...) environment.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (env_cd) NOT ENFORCED
) OPTIONS(description='Development, Test_1 and Production can be separated by using different environments.');