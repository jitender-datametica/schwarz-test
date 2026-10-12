--==============================================================
-- Table: T_DATA_QUALITY_DIMENSION_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_DATA_QUALITY_DIMENSION_2
   generated from Powerdesigner on Montag, 7. November 2022 10:16:19
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_DATA_QUALITY_DIMENSION_2 (
   DQ_DIMENSION_CD                     VARCHAR(50)     NOT NULL COMMENT 'A code identifying the basic aspect by which data quality is measured. E.g. correctness, timeliness, completeness, consistency, etc.',
   DQ_DIMENSION_NAME                   VARCHAR(100)    NOT NULL COMMENT 'The name of the basic aspect by which data quality is measured. E.g. correctness, timeliness, completeness, consistency, etc.',
   DQ_DIMENSION_DESCR                  VARCHAR(250)    NOT NULL COMMENT 'The definition of the data quality dimension.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   DWH_NODE_CD                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DATA_QUALITY_DIMENSION PRIMARY KEY (DQ_DIMENSION_CD) NOT ENFORCED
 )  COMMENT= 'Minor Entity - A data quality dimension describes the basic aspects by which data quality is measured. E.g. correctness, timeliness, completeness, consistency, etc.';

