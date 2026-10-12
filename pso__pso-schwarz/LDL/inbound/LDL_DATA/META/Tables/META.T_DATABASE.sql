/* --------------------------------------------------------------------------------
   DDL for table: t_database
   generated from Powerdesigner on Donnerstag, 21. September 2023 14:44:55
*/ --------------------------------------------------------------------------------

CREATE TABLE meta.T_DATABASE (
   sys_name                            VARCHAR(100)    NOT NULL COMMENT 'The name of the IT system.',
   db_name                             VARCHAR(100)    NOT NULL COMMENT 'The name by which the database is identified on the system.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   env_cd                              VARCHAR(20)     COMMENT 'The code for the environment, in case the entire database is dedicated to one environment.',
   db_descr                            VARCHAR(250)    COMMENT 'A textual description of the database, explaining its purpose.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DATABASE PRIMARY KEY (db_name, sys_name, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'A database is a container in a DBMS for other objects.';