/* --------------------------------------------------------------------------------
   DDL for table: t_storage_test_result_1
   generated from Powerdesigner on Dienstag, 19. September 2023 17:16:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_storage_test_result_1 (
storage_test_exec_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key for individual test_1 execution.'),
storage_test_result_grp_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate key for result grouping.'),
storage_test_metric_type_cd STRING(100) NOT NULL OPTIONS(description='Type of measure in a storage test.'),
curr_sid BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key CURRENCY.'),
actual_val BIGNUMERIC(38,5) OPTIONS(description='The actual value of the metrics.'),
anticipated_val BIGNUMERIC(38,5) OPTIONS(description='The expected value of the metrics.'),
spread_pct BIGNUMERIC(38,5) OPTIONS(description='The result spread.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='The timestamp when the row was inserted.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The timestamp when the row was updated the last time.'),
PRIMARY KEY (storage_test_exec_sid, storage_test_result_grp_sid, storage_test_metric_type_cd) NOT ENFORCED
) OPTIONS(description='A table that stores results for a storage test_1 run.             Source: FTM ');