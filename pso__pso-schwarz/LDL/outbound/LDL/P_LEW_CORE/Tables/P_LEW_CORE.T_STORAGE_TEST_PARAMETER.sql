/* --------------------------------------------------------------------------------
   DDL for table: t_storage_test_parameter
   generated from Powerdesigner on Dienstag, 19. September 2023 17:15:35
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_storage_test_parameter (
storage_test_exec_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key for individual test executions.'),
storage_test_result_grp_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate key for result grouping.'),
storage_test_param_type_cd STRING(100) NOT NULL OPTIONS(description='Type of the parameter for a storage test.'),
param_txt STRING(1000) OPTIONS(description='Text value of parameter.'),
param_pct BIGNUMERIC(38,5) OPTIONS(description='Percent value of parameter.'),
param_meas BIGNUMERIC(38,5) OPTIONS(description='Numeric value of a parameter.'),
param_fg BIGNUMERIC(38,0) OPTIONS(description='Flag value of a parameter.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='The timestamp when the row was inserted.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The timestamp when the row was updated the last time.'),
PRIMARY KEY (storage_test_exec_sid, storage_test_result_grp_sid, storage_test_param_type_cd) NOT ENFORCED
) OPTIONS(description='A table that stores values of parameters used in the storage test run.             Source: FTM');