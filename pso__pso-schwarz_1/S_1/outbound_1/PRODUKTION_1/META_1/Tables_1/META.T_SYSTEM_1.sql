--==============================================================
-- Table: T_SYSTEM_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_SYSTEM_1
   generated from Powerdesigner on Montag, 7. November 2022 10:16:19
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS produktion_meta.t_system_1 (
sys_name STRING(100) NOT NULL OPTIONS(description='The name of the IT system.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
sys_descr STRING(250) OPTIONS(description='A textual description of the database, explaining its purpose.'),
sys_type_cd STRING(50) NOT NULL
OPTIONS(description='The code identifying the type of system, e.g. the Cloud Data Warehouse, the data store, operational systems, the ETL tool, ...'),
env_cd STRING(50)
OPTIONS(description='The code for the environment, in case the entire system is dedicated to one environment.'),
technology_name STRING(100)
OPTIONS(description='The name of the technology on which the system operates, e.g. Teradata, Snowflake, Microstrategy, ...'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (sys_name, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='An IT system, either on premise or in the cloud. This includes source systems, downstream systems and of course also the data warehouse and the data store.');