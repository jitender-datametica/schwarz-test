--==============================================================
-- Table: T_SCHEDULING_FREQUENCY
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_SCHEDULING_FREQUENCY
   generated from Powerdesigner on Montag, 7. November 2022 10:16:20
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_SCHEDULING_FREQUENCY (
   SCHEDULING_FREQ_CD                  VARCHAR(50)     NOT NULL COMMENT 'A code defining, how often a scheduling unit or a test is executed. E.g daily, weekly, ...',
   SCHEDULING_FREQ_DESCR               VARCHAR(250)    NOT NULL COMMENT 'A textual description for the scheduling frequency.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   DWH_NODE_CD                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_SCHEDULING_FREQUENCY PRIMARY KEY (SCHEDULING_FREQ_CD) NOT ENFORCED
 )  COMMENT= 'This minor entity describes, how often a scheduling unit or a test is executed. E.g. daily, weekly, ...';

