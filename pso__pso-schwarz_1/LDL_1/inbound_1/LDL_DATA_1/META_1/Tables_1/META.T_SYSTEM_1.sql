/* --------------------------------------------------------------------------------
   DDL for table: t_system_1
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_SYSTEM_1 (
   sys_name                            VARCHAR(100)    NOT NULL COMMENT 'The name of the IT system.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   sys_descr                           VARCHAR(250)    COMMENT 'A textual description of the database, explaining its purpose.',
   sys_type_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code identifying the type of system, e.g. the Cloud Data Warehouse, the data store, operational systems, the ETL tool, ...',
   env_cd                              VARCHAR(20)     COMMENT 'The code for the environment, in case the entire system is dedicated to one environment.',
   technology_name                     VARCHAR(100)    COMMENT 'The name of the technology on which the system operates, e.g. Teradata, Snowflake, Microstrategy, ...',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_SYSTEM PRIMARY KEY (sys_name, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'An IT system, either on premise or in the cloud. This includes source systems, downstream systems and of course also the data warehouse and the data store.';
