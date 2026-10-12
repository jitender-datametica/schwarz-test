/* --------------------------------------------------------------------------------
   DDL for table: t_storage_test_execution_2
   generated from Powerdesigner on Dienstag, 19. September 2023 16:57:27
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_STORAGE_TEST_EXECUTION_2 (
   client_id                           NUMBER(38,0)     COMMENT 'Surrogate Key CLIENT spf_section.EXTDESC21.',
   storage_test_exec_sid               NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key for individual test_2 execution.',
   storage_test_exec_name              VARCHAR(100)     COMMENT 'A name for a singular test_2 execution.',
   end_week                            NUMBER(38,0)     COMMENT 'The last week of the test.',
   dur_week_cnt                        NUMBER(38,0)     COMMENT 'A number of weeks during which test_2 was executed.',
   min_training_day_cnt                NUMBER(38,0)     COMMENT 'A minimum training day number.',
   spread_pct                          NUMBER(38,5)     COMMENT 'A spread that defines the tolerance for result deviation between model results and real results.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was inserted.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was updated the last time.',   
   CONSTRAINT PK_T_STORAGE_TEST_EXECUTION PRIMARY KEY (storage_test_exec_sid) NOT ENFORCED 
)  COMMENT = 'The table that stores the results for the testing of different storage tests (for example when one of the store changes the way products are situated on the shelves and compares the results with the predicted results of similar stores).
             Source: FTM';
