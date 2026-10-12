/* --------------------------------------------------------------------------------
   DDL for table: t_storage_test_result_group_type_2
   generated from Powerdesigner on Dienstag, 19. September 2023 17:19:33
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_storage_test_result_group_type_2 (
storage_test_result_grp_type_cd STRING(100) NOT NULL
OPTIONS(description='A code for the type of grouping used in storage test_2 results (general, store, user defined group, product group).'),
storage_test_result_grp_type_descr STRING(250) NOT NULL OPTIONS(description='A description for test_2 storage group type'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='The timestamp when the row was inserted.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The timestamp when the row was updated the last time.'),
PRIMARY KEY (storage_test_result_grp_type_cd) NOT ENFORCED
)
OPTIONS(description='A reference table that contains types of groupings used in storage test_2 results (general, store, user defined group, product group).             Source: FTM ( manual static mapping)');