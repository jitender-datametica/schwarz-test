/* --------------------------------------------------------------------------------
   DDL for table: t_storage_test_result_group_type_2
   generated from Powerdesigner on Dienstag, 19. September 2023 17:19:33
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_STORAGE_TEST_RESULT_GROUP_TYPE_2 (
   storage_test_result_grp_type_cd     VARCHAR(100)     NOT NULL COMMENT 'A code for the type of grouping used in storage test_2 results (general, store, user defined group, product group).',
   storage_test_result_grp_type_descr  VARCHAR(250)     NOT NULL COMMENT 'A description for test_2 storage group type',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was inserted.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was updated the last time.',   
   CONSTRAINT PK_T_STORAGE_TEST_RESULT_GROUP_TYPE PRIMARY KEY (storage_test_result_grp_type_cd) NOT ENFORCED 
)  COMMENT = 'A reference table that contains types of groupings used in storage test_2 results (general, store, user defined group, product group).
             Source: FTM ( manual static mapping)';
