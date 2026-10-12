--==============================================================
-- Table: T_FILE_TYPE_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_FILE_TYPE_1
   generated from Powerdesigner on Montag, 7. November 2022 10:16:19
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_FILE_TYPE_1 (
   FILE_TYPE_CD                        VARCHAR(50)     NOT NULL COMMENT 'The code for the subtype discriminator for files.',
   FILE_TYPE_DESCR                     VARCHAR(250)    NOT NULL COMMENT 'A textual description for the subtype discriminator for files.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   DWH_NODE_CD                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_FILE_TYPE PRIMARY KEY (FILE_TYPE_CD) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the subtype discriminators for files. It distinguishes between CSV files, AVRO files, AVRO schema definitions and Parquet files.';

