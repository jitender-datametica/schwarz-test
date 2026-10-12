CREATE OR REPLACE VIEW ldl_data_production_meta.v_test_lifecycle_status (test_lifecycle_status_cd
OPTIONS(description='The code identifying the lifecycle status of a test. E.g. draft, approved, expired, ...'),
test_lifecycle_status_descr OPTIONS(description='A textual description for the lifecycle status of a test.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THIS MINOR ENTITY DEFINES THE LIFECYCLE STATUS OF A TEST. E.G. IT SHOWS, IF A DATA QUALITY RULE IS IN DRAFT, IF IT HAS BEEN APPROVED, OR IF IT HAS BEEN EXPIRED.`)
AS SELECT test_lifecycle_status_cd,
 test_lifecycle_status_descr,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_meta.t_test_lifecycle_status
UNION DISTINCT
SELECT '@',
 'Unknown lifecycle status',
 CURRENT_TIMESTAMP(),
 CURRENT_TIMESTAMP(),
 - 1,
 'MANUAL';