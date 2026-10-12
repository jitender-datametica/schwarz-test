/* --------------------------------------------------------------------------------
   DDL for table: t_storage_test_execution
   generated from Powerdesigner on Dienstag, 19. September 2023 16:57:27
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_storage_test_execution (
client_id BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key CLIENT spf_section.EXTDESC21.'),
storage_test_exec_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key for individual test execution.'),
storage_test_exec_name STRING(100) OPTIONS(description='A name for a singular test execution.'),
end_week BIGNUMERIC(38,0) OPTIONS(description='The last week of the test.'),
dur_week_cnt BIGNUMERIC(38,0) OPTIONS(description='A number of weeks during which test was executed.'),
min_training_day_cnt BIGNUMERIC(38,0) OPTIONS(description='A minimum training day number.'),
spread_pct BIGNUMERIC(38,5)
OPTIONS(description='A spread that defines the tolerance for result deviation between model results and real results.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='The timestamp when the row was inserted.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The timestamp when the row was updated the last time.'),
PRIMARY KEY (storage_test_exec_sid) NOT ENFORCED
)
OPTIONS(description='The table that stores the results for the testing of different storage tests (for example when one of the store changes the way products are situated on the shelves and compares the results with the predicted results of similar stores).             Source: FTM');