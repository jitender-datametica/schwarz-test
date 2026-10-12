--==============================================================
-- Table: T_SYSTEM_PARTITION_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_SYSTEM_PARTITION_2
   generated from Powerdesigner on Montag, 7. November 2022 10:16:20
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_SYSTEM_PARTITION_2 (
   SYS_PARTITION_CD                    VARCHAR(50)     NOT NULL COMMENT 'The code which uniquely identifies the part or the instance of an IT system.',
   SYS_NAME                            VARCHAR(100)    NOT NULL COMMENT 'The name of the IT system to which the partition belongs.',
   SYS_PARTITION_NAME                  VARCHAR(100)    NOT NULL COMMENT 'The name for the part or the instance of an IT system. E.g. Wawi Germany.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   DWH_NODE_CD                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_SYSTEM_PARTITION PRIMARY KEY (SYS_PARTITION_CD) NOT ENFORCED
 )  COMMENT= 'A part or an instance of an IT system, which runs independently.E.g. a Wawi instance.';

