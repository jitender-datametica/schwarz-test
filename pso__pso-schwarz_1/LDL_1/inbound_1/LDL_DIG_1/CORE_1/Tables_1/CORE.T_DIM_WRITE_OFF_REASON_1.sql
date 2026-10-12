/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_WRITE_OFF_REASON_1
   GENERATED FROM POWERDESIGNER ON Montag, 18. November 2024 15:39:21
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_WRITE_OFF_REASON_1 (
   WRITE_OFF_REASON_CD                 VARCHAR(5)      NOT NULL COMMENT 'Code for the reason of the write-off operation.',
   WRITE_OFF_REASON_DESCR              VARCHAR(250)    NOT NULL COMMENT 'Description for the reason of the write-off operation.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_DIM_WRITE_OFF_REASON PRIMARY KEY (WRITE_OFF_REASON_CD) NOT ENFORCED 
)  COMMENT = 'A minor dimension that contains detailed descriptions of the different write-off reasons.';
