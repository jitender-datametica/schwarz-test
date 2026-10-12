CREATE OR REPLACE VIEW ldl_data_production_meta.v_schema_2 (sys_name OPTIONS(description='The name of the IT system.'),
db_name OPTIONS(description='The name by which the database is identified on the system.'), schema_name
OPTIONS(description='The name of the schema, as it is defined in the database management system.'), dwh_valid_from_tmsp
OPTIONS(description='The point in time when this record became valid.'), dwh_valid_to_tmsp
OPTIONS(description='The point in time when this record was no longer valid.'), dwh_valid_fg
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
env_cd
OPTIONS(description='The code which identifies the (development / test_2 / production / ...) environment for which the schema is used.'),
schema_descr OPTIONS(description='A textual description of the database schema, explaining its purpose.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `A SCHEMA DEFINES A NAME SPACE IN A DATABASE MANAGEMENT SYSTEM. OTHER OBJECTS, SUCH AS TABLES AND VIEWS, ARE CREATED IN A SCHEMA.`)
AS SELECT sys_name,
 db_name,
 schema_name,
 dwh_valid_from_tmsp,
 dwh_valid_to_tmsp,
 dwh_valid_fg,
 env_cd,
 schema_descr,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_meta.t_schema_2
UNION DISTINCT
SELECT '@',
 '@',
 '@',
 CAST('1900-01-01 00:00:00.000 +0100' AS TIMESTAMP),
 CAST('9999-12-31 23:59:00.000 +0100' AS TIMESTAMP),
 TRUE,
 '@',
 'Unknown schema',
 CURRENT_TIMESTAMP(),
 CURRENT_TIMESTAMP(),
 - 1,
 'MANUAL';