CREATE OR REPLACE VIEW ldl_data_production_meta.v_test_origin (test_origin_cd
OPTIONS(description='The code identifying the operational source which defines the test.'), test_origin_descr
OPTIONS(description='A textual description for the operational source which defines the test.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THIS MINOR ENTITY DEFINES THE OPERATIONAL SOURCES WHICH DEFINES THE TESTS. E.G. A DATA QUALITY RULE CAN BE DEFINED IN THE AB INITIO DQ FRAMEWORK OR IN INFORMATICA.`)
AS SELECT test_origin_cd,
 test_origin_descr,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_meta.t_test_origin
UNION DISTINCT
SELECT '@',
 'Unknown test origin',
 CURRENT_TIMESTAMP(),
 CURRENT_TIMESTAMP(),
 - 1,
 'MANUAL';