CREATE OR REPLACE VIEW ldl_data_production_meta.v_database_1 (sys_name OPTIONS(description='The name of the IT system.'),
db_name OPTIONS(description='The name by which the database is identified on the system.'), dwh_valid_from_tmsp
OPTIONS(description='The point in time when this record became valid.'), dwh_valid_to_tmsp
OPTIONS(description='The point in time when this record was no longer valid.'), dwh_valid_fg
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
tenant_cd
OPTIONS(description='The code identifying the tenant, i.e. the organizational unit_1 within the Schwarz Group which operates its own data warehouse. I.e. Lidl, Kaufland, Lidl Digital, etc.'),
env_cd OPTIONS(description='The code for the environment, in case the entire database is dedicated to one environment.'),
db_descr OPTIONS(description='A textual description of the database, explaining its purpose.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `A DATABASE IS A CONTAINER IN A DBMS FOR OTHER OBJECTS.`) AS SELECT sys_name,
 db_name,
 dwh_valid_from_tmsp,
 dwh_valid_to_tmsp,
 dwh_valid_fg,
 tenant_cd,
 env_cd,
 db_descr,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_meta.t_database_1
UNION DISTINCT
SELECT '@',
 '@',
 CAST('1900-01-01 00:00:00.000 +0100' AS TIMESTAMP),
 CAST('9999-12-31 23:59:00.000 +0100' AS TIMESTAMP),
 TRUE,
 '@',
 '@',
 'Unknown database',
 CURRENT_TIMESTAMP(),
 CURRENT_TIMESTAMP(),
 - 1,
 'MANUAL';