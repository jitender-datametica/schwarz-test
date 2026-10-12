--==============================================================
-- Table: T_SYSTEM_TYPE_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_SYSTEM_TYPE_1
   generated from Powerdesigner on Montag, 7. November 2022 10:16:20
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_SYSTEM_TYPE_1 (
   SYS_TYPE_CD                         VARCHAR(50)     NOT NULL COMMENT 'The code identifying the type of system, e.g. the Cloud Data Warehouse, the data store, operational systems, the ETL tool, ...',
   SYS_TYPE_DESCR                      VARCHAR(250)    NOT NULL COMMENT 'A textual description for the type of system.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   DWH_NODE_CD                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_SYSTEM_TYPE PRIMARY KEY (SYS_TYPE_CD) NOT ENFORCED
 )  COMMENT= 'This minor entity can be used to classify systems, e.g. the Cloud Data Warehouse, the data store, operational systems, the ETL tool, ...';

