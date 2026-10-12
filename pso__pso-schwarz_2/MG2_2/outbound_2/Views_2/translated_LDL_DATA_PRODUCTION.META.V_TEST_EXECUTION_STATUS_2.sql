CREATE OR REPLACE VIEW ldl_data_production_meta.v_test_execution_status_2 (test_exec_status_cd
OPTIONS(description='A code identifying the overall result of a test_2, e.g. success or failed.'), test_exec_status_descr
OPTIONS(description='A textual description for the overall result of a test_2, e.g. success or failed.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THIS MINOR ENTITY DEFINES THE POSSIBLE OVERALL OUTCOMES OF A TEST. A TEST_2 MAY BE SUCCESSFUL OR HAS FAILED. (NOTE THAT THIS IS NOT THE CHECK RESULT OF AN INDIVIDUAL RECORD!)`)
AS SELECT test_exec_status_cd,
 test_exec_status_descr,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_meta.t_test_execution_status_2
UNION DISTINCT
SELECT '@',
 'Unknown status_2',
 CURRENT_TIMESTAMP(),
 CURRENT_TIMESTAMP(),
 - 1,
 'MANUAL';