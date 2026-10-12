--==============================================================
-- Table: T_TEST_KEY
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_TEST_KEY
   generated from Powerdesigner on Montag, 7. November 2022 10:16:20
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_TEST_KEY (
   TEST_SID                            NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the Test.',
   TEST_KEY_TYPE_CD                    VARCHAR(50)     NOT NULL COMMENT 'The code for the type of natural key which identifies the Test.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   TEST_NAT_KEY_NR                     VARCHAR(250)    NOT NULL COMMENT 'The natural key which identifies the Test.In case the natural key consist of several columns, all components get concatenated.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_LOAD_ID                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   DWH_NODE_CD                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_TEST_KEY PRIMARY KEY (TEST_SID, TEST_KEY_TYPE_CD, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'Key table for the Test key space. A surrogate key is identified by one or several natural keys. The kind of natural key is defined by the key type code. In case the natural key consists of several columns, all components get concatenated using a separator character. The association between a natural key and its surrogate key can change over time, e.g. because of a re-numbering in the source. That is why the key table is historized.';

