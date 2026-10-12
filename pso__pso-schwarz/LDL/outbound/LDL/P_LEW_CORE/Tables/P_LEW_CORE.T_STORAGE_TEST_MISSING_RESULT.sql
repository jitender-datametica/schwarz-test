/* --------------------------------------------------------------------------------
   DDL for table: t_storage_test_missing_result
   generated from Powerdesigner on Dienstag, 19. September 2023 17:13:40
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_storage_test_missing_result (
storage_test_exec_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key for individual test executions.'),
storage_test_result_grp_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate key for result grouping.'),
storage_test_metric_type_cd STRING(100) NOT NULL OPTIONS(description='Type of measure in a storage test.'),
reason_descr STRING(250) OPTIONS(description='A reason why a result is missing.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='The timestamp when the row was inserted.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The timestamp when the row was updated the last time.'),
PRIMARY KEY (storage_test_exec_sid, storage_test_metric_type_cd, storage_test_result_grp_sid) NOT ENFORCED
) OPTIONS(description='Groups and KPI that are missing from the results after test execution.');