create or replace view LDL_DATA_PRODUCTION.META.V_TEST_ORIGIN_1(
	TEST_ORIGIN_CD COMMENT 'The code identifying the operational source which defines the test.',
	TEST_ORIGIN_DESCR COMMENT 'A textual description for the operational source which defines the test.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='This minor entity defines the operational sources which defines the tests. E.g. a data quality rule can be defined in the Ab Initio DQ framework or in Informatica.'
 as
SELECT
   test_origin_cd
  ,test_origin_descr
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_load_id
  ,dwh_node_cd
FROM META.T_TEST_ORIGIN_1
UNION
SELECT '@', 'Unknown test_1 origin', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, -1, 'MANUAL'
;