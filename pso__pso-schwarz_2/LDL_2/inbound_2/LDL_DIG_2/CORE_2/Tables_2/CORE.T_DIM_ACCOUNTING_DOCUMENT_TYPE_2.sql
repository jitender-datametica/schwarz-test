/* --------------------------------------------------------------------------------
   DDL FOR TABLE: CORE.T_DIM_ACCOUNTING_DOCUMENT_TYPE_2
   GENERATED FROM POWERDESIGNER ON Mittwoch, 9. Februar 2022 10:15:10
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_ACCOUNTING_DOCUMENT_TYPE_2 (
   ACCT_DOC_TYPE_CD                    VARCHAR(5)      NOT NULL COMMENT 'Unique identifier of the document type',
   ACC_DOC_TYPE_NAME_EN                VARCHAR(100)    COMMENT 'Name (description) of the accounting document type in English',
   ACC_DOC_TYPE_NAME_DE                VARCHAR(100)    COMMENT 'Name (description) of the accounting document type in German',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_ACCT_DOC_TYPE PRIMARY KEY (ACCT_DOC_TYPE_CD)
       NOT ENFORCED
)COMMENT = 'A minor dimension that contains all the types of Accounting Documents';
