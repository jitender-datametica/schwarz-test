CREATE TABLE CORE.T_DIM_SALES_DOCUMENT_TYPE (
   SALE_DOC_TYPE_CD                    VARCHAR(5)      NOT NULL COMMENT 'The code for the the delivery document ( C (Order), H (Return), I (Order w/o charge), V (Purchase Order) )',
   SALE_DOC_TYPE_DESCR                 VARCHAR(250)    NOT NULL COMMENT 'The textual description for the original document type',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_SALES_DOCUMENT_TYPE PRIMARY KEY (SALE_DOC_TYPE_CD)
       NOT ENFORCED
)
COMMENT = 'Type of the document that trigger the delivery document ( C (Order), H (Return), I (Order w/o charge), V (Purchase Order) )';
