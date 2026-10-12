/* --------------------------------------------------------------------------------
   DDL for table: t_database
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_meta.t_database (
sys_name STRING(100) NOT NULL OPTIONS(description='The name of the IT system.'),
db_name STRING(100) NOT NULL OPTIONS(description='The name by which the database is identified on the system.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
env_cd STRING(20)
OPTIONS(description='The code for the environment, in case the entire database is dedicated to one environment.'),
db_descr STRING(250) OPTIONS(description='A textual description of the database, explaining its purpose.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (db_name, sys_name, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='A database is a container in a DBMS for other objects.');