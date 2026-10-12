/* --------------------------------------------------------------------------------
   DDL for table: t_storage_test_store_relation_2
   generated from Powerdesigner on Dienstag, 19. September 2023 17:20:45
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_storage_test_store_relation_2 (
storage_test_exec_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key for individual test_2 execution.'),
loc_sid_store BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key LOCATION_2 for a store that partecipates in test.'),
rel_loc_sid_store BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key LOCATION_2 for a referenced store that is used to create a digital twin.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='The timestamp when the row was inserted.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The timestamp when the row was updated the last time.'),
PRIMARY KEY (storage_test_exec_sid, loc_sid_store, rel_loc_sid_store) NOT ENFORCED
)
OPTIONS(description='The table that stores which stores were selected for the testing of different storage options.             Source: FTM');