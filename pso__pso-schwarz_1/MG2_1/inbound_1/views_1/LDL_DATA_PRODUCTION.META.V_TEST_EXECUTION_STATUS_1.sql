create or replace view LDL_DATA_PRODUCTION.META.V_TEST_EXECUTION_STATUS_1(
	TEST_EXEC_STATUS_CD COMMENT 'A code identifying the overall result of a test_1, e.g. success or failed.',
	TEST_EXEC_STATUS_DESCR COMMENT 'A textual description for the overall result of a test_1, e.g. success or failed.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='This minor entity defines the possible overall outcomes of a test. A test_1 may be successful or has failed. (Note that this is not the check result of an individual record!)'
 as
SELECT
   test_exec_status_cd
  ,test_exec_status_descr
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_load_id
  ,dwh_node_cd
FROM META.T_TEST_EXECUTION_STATUS_1
UNION
SELECT '@', 'Unknown status_1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, -1, 'MANUAL'
;