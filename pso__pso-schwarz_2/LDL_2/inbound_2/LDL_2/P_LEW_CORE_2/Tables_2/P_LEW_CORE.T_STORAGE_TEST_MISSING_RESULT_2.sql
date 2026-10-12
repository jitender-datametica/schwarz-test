/* --------------------------------------------------------------------------------
   DDL for table: t_storage_test_missing_result_2
   generated from Powerdesigner on Dienstag, 19. September 2023 17:13:40
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_STORAGE_TEST_MISSING_RESULT_2 (
   storage_test_exec_sid               NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key for individual test_2 executions.',
   storage_test_result_grp_sid         NUMBER(38,0)     NOT NULL COMMENT 'Surrogate key for result grouping.',
   storage_test_metric_type_cd         VARCHAR(100)     NOT NULL COMMENT 'Type of measure in a storage test.',
   reason_descr                        VARCHAR(250)     COMMENT 'A reason why a result is missing.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was inserted.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was updated the last time.',   
   CONSTRAINT PK_T_STORAGE_TEST_MISSING_RESULT PRIMARY KEY (storage_test_exec_sid, storage_test_metric_type_cd, storage_test_result_grp_sid) NOT ENFORCED 
)  COMMENT = 'Groups and KPI that are missing from the results after test_2 execution.';
