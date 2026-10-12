--==============================================================
-- Table: T_SYSTEM_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_SYSTEM_2
   generated from Powerdesigner on Montag, 7. November 2022 10:16:19
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_SYSTEM_2 (
   SYS_NAME                            VARCHAR(100)    NOT NULL COMMENT 'The name of the IT system.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   SYS_DESCR                           VARCHAR(250)    COMMENT 'A textual description of the database, explaining its purpose.',
   SYS_TYPE_CD                         VARCHAR(50)     NOT NULL COMMENT 'The code identifying the type of system, e.g. the Cloud Data Warehouse, the data store, operational systems, the ETL tool, ...',
   ENV_CD                              VARCHAR(50)     COMMENT 'The code for the environment, in case the entire system is dedicated to one environment.',
   TECHNOLOGY_NAME                     VARCHAR(100)    COMMENT 'The name of the technology on which the system operates, e.g. Teradata, Snowflake, Microstrategy, ...',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   DWH_NODE_CD                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_SYSTEM PRIMARY KEY (SYS_NAME, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'An IT system, either on premise or in the cloud. This includes source systems, downstream systems and of course also the data warehouse and the data store.';

