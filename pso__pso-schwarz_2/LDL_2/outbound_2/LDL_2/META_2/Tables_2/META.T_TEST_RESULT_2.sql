/* --------------------------------------------------------------------------------
   DDL for table: t_test_result_2
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:56
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_meta.t_test_result_2 (
test_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for a test.'),
test_exec_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the test_2 was executed.'),
test_type_cd STRING(20) NOT NULL
OPTIONS(description='A code identifying the subtype discriminators for tests. It distinguishes between data quality rules, data profiling, ETL audits and development tests.'),
test_exec_status_cd STRING(20)
OPTIONS(description='A code identifying the overall result of a test_2, e.g. success or failed.'),
total_rec_cnt BIGNUMERIC(38,0)
OPTIONS(description='The total number of records which were the input for this data quality check.'),
skipped_rec_cnt BIGNUMERIC(38,0)
OPTIONS(description='The number of records for which the data quality check was not executed.'),
passed_rec_cnt BIGNUMERIC(38,0) OPTIONS(description='The number of records which passed the data quality check.'),
failed_rec_cnt BIGNUMERIC(38,0) OPTIONS(description='The number of records which failed the data quality check.'),
profiling_result_meas BIGNUMERIC(38,5)
OPTIONS(description='The result value that was produced by the data profiling rule. E.g. a maximum value of 100 for a given column.'),
expected_meas BIGNUMERIC(38,5)
OPTIONS(description='The expected measure. E.g. the number of files which should have been loaded.'),
observed_meas BIGNUMERIC(38,5)
OPTIONS(description='The actual measure which was observed during the execution of the ETL job. E.g. the actual number of files which have been loaded.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (test_sid, test_exec_tmsp) NOT ENFORCED
) OPTIONS(description='The execution of a test_2 leads to a result.');