/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_CUST_AGE_SEGMENT_TYPE_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 7. Juli 2022 12:02:33
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CUST_AGE_SEGMENT_TYPE_1 (
   CUST_AGE_SEGM_TYPE_CD               VARCHAR(20)     NOT NULL COMMENT 'A code for a type to distinquish customer age clustering for different departments',
   CUST_AGE_SEGM_TYPE_DESCR            VARCHAR(250)    COMMENT 'The textual description for the customer age type',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_CUST_AGE_SEGMENT_TYPE PRIMARY KEY (CUST_AGE_SEGM_TYPE_CD) NOT ENFORCED
 )  COMMENT= 'This dimension defines a type to distinquish customer age clustering for different departments';
