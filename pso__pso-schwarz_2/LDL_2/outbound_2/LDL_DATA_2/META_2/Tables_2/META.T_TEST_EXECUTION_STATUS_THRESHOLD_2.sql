/* --------------------------------------------------------------------------------
   DDL for table: t_test_execution_status_threshold_2
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:56
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_meta.t_test_execution_status_threshold_2 (
test_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for a test.'),
test_exec_status_cd STRING(20) NOT NULL
OPTIONS(description='A code identifying the overall result of a test_2, e.g. success or failed.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
threshold_pct BIGNUMERIC(38,5)
OPTIONS(description='The percentage of checked records which need to pass the test_2, so that the entire test_2 is classified with the given result code. E.g. 95% -> pass, 80% warning'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (test_sid, test_exec_status_cd, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='This entity defines the percentage of checked records which need to pass the test_2, so that the entire test_2 is classified with the given result code. E.g. 95% -> pass, 80% warning');