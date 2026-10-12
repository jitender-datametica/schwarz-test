create or replace view LDL_DATA_PRODUCTION.META.V_TEST_LIFECYCLE_STATUS_2(
	TEST_LIFECYCLE_STATUS_CD COMMENT 'The code identifying the lifecycle status_2 of a test. E.g. draft, approved, expired, ...',
	TEST_LIFECYCLE_STATUS_DESCR COMMENT 'A textual description for the lifecycle status_2 of a test.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='This minor entity defines the lifecycle status_2 of a test. E.g. it shows, if a data quality rule is in draft, if it has been approved, or if it has been expired.'
 as
SELECT
   test_lifecycle_status_cd
  ,test_lifecycle_status_descr
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_load_id
  ,dwh_node_cd
FROM META.T_TEST_LIFECYCLE_STATUS_2
UNION
SELECT '@', 'Unknown lifecycle status_2', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, -1, 'MANUAL'
;