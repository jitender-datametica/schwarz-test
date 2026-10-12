--==============================================================
-- Table: T_TEST_LIFECYCLE_STATUS_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_TEST_LIFECYCLE_STATUS_2
   generated from Powerdesigner on Montag, 7. November 2022 10:16:20
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_meta.t_test_lifecycle_status_2 (
test_lifecycle_status_cd STRING(50) NOT NULL
OPTIONS(description='The code identifying the lifecycle status_2 of a test. E.g. draft, approved, expired, ...'),
test_lifecycle_status_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the lifecycle status_2 of a test.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (test_lifecycle_status_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - This minor entity defines the lifecycle status_2 of a test. E.g. it shows, if a data quality rule is in draft, if it has been approved, or if it has been expired.');