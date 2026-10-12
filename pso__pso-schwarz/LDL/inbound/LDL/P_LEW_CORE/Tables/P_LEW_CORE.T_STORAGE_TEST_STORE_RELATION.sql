/* --------------------------------------------------------------------------------
   DDL for table: t_storage_test_store_relation
   generated from Powerdesigner on Dienstag, 19. September 2023 17:20:45
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_STORAGE_TEST_STORE_RELATION (
   storage_test_exec_sid               NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key for individual test execution.',
   loc_sid_store                       NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key LOCATION for a store that partecipates in test.',
   rel_loc_sid_store                   NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key LOCATION for a referenced store that is used to create a digital twin.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was inserted.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was updated the last time.',   
   CONSTRAINT PK_T_STORAGE_TEST_STORE_RELATION PRIMARY KEY (storage_test_exec_sid, loc_sid_store, rel_loc_sid_store) NOT ENFORCED 
)  COMMENT = 'The table that stores which stores were selected for the testing of different storage options.
             Source: FTM';
