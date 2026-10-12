/* --------------------------------------------------------------------------------
   DDL for table: t_test_execution_status_1
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:56
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_meta.t_test_execution_status_1 (
test_exec_status_cd STRING(20) NOT NULL
OPTIONS(description='A code identifying the overall result of a test_1, e.g. success or failed.'),
test_exec_status_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the overall result of a test_1, e.g. success or failed.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (test_exec_status_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the possible overall outcomes of a test. A test_1 may be successful or has failed. (Note that this is not the check result of an individual record!)');